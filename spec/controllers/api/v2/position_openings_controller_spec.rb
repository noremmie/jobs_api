require 'spec_helper'

describe Api::V2::PositionOpeningsController do
  describe '#search' do
    let(:search_params) do
      {'query' => 'tsa jobs', 'organization_id' => 'ABCD', 'tags' => 'state city', 'from' => '2', 'size' => '3',
       'hl' => '1', 'lat_lon' => '37.41919999999,-122.0574'}
    end

    let(:search_results) { mock('search results') }

    before do
      PositionOpening.should_receive(:search_for).with(search_params).and_return(search_results)
      get 'search', query: 'tsa jobs', organization_id: 'ABCD', tags: 'state city', from: '2', size: '3', hl: '1',
          lat_lon: '37.41919999999,-122.0574', format: :json
    end

    it { should respond_with(:success) }

    it 'should respond with content type json' do
      response.content_type.should =~ /json/
    end

    it 'should assign search results to position openings' do
      assigns[:position_openings].should == search_results
    end

    it { should render_template(:search) }
  end
end