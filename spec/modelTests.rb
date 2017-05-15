require 'rspec/autorun'
require 'nokogiri'
require 'vcr'
require 'webmock/rspec'
require_relative '../lib/indexParser'
require_relative '../lib/filmParser'

require 'byebug'
# require 'active_support/core_ext/kernel/reporting'
require_relative '../spec/support/vcr_setup'
WebMock.disable_net_connect!(allow_localhost: true)


index_url = "http://oscars.yipitdata.com/"
chariots_url = 'http://oscars.yipitdata.com/films/Chariots_of_Fire'
deer_hunter_url = 'http://oscars.yipitdata.com/films/The_Deer_Hunter'

describe "IndexParser" do
  let (:response) {IndexParser.new(index_url)}
    describe '#initialize' do
      it 'is an instance of IndexParser' do
        VCR.use_cassette 'model/films_data' do
          expect(response).to be_an_instance_of(IndexParser)
        end
      end
      it 'parses the API data into an array of hashes' do
        VCR.use_cassette 'model/films_data' do
          expect(response.data_hash).to be_a(Array)
          expect(response.data_hash[0]).to be_a(Hash)
        end
      end
    end
  end
  describe 'FilmParser' do
    let (:chariot_data) {FilmParser.new(chariots_url)}
    let (:deer_data) {FilmParser.new(deer_hunter_url)}

    describe '#initialize' do
      it 'is an instance of FilmParser' do
        VCR.use_cassette 'model/chariots_data' do
          expect(chariot_data).to be_an_instance_of(FilmParser)
        end
      end
    end
    describe '#parse_budget' do
      it 'takes a budget string and returns a number' do
        VCR.use_cassette 'model/deer_hunter_data' do
          @budget_string = deer_data.film_page['Budget']
        end
        expect(deer_data.parse_budget(@budget_string)).to be_a(Integer)
      end

      it 'translates all currencies to USD' do
        VCR.use_cassette 'model/chariots_data' do
          @budget_num = chariot_data.get_budget
          @budget_string = chariot_data.film_page['Budget']
          @budget_number_not_converted = @budget_string.slice(@budget_string.index('£')+1..-1).split(' ').detect{|term| term.to_f > 0}.to_i
          @budget_converted = @budget_number_not_converted.to_i * 1.29
        end
        expect(@budget_string.include?('£')).to eq(true)
        expect(@budget_num * 1000000 > @budget_number_not_converted).to eq(true)
        expect(@budget_num == @budget_converted.round).to eq(true)
      end
    end
end
