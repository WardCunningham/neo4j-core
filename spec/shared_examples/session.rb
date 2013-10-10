share_examples_for "Neo4j::Session" do

  describe 'query' do
    it 'returns data as arrays of hashs' do
      result = @session.query("START n=node(0) RETURN ID(n)")
      result.to_a.count.should == 1
      result.first.should == {:'ID(n)' => 0}
    end

    it 'allows parameters for the query' do
      result = @session.query("START n=node({a_parameter}) RETURN ID(n)", a_parameter: 0)
      result.to_a.count.should == 1
      result.first.should == {:'ID(n)' => 0}
    end

    it 'accepts an cypher DSL with parameters' do
      result = @session.query(a_parameter: 0) { node("{a_parameter}").neo_id.as(:foo)}
      result.to_a.count.should == 1
      result.first.should == {:foo => 0}
    end

    it 'accepts an cypher DSL without parameters' do
      result = @session.query{node(0).neo_id.as(:foo)}
      result.to_a.count.should == 1
      result.first.should == {:foo => 0}
    end

    it 'raise Neo4j::Session::CypherError for invalid cypher query' do
      expect{@session.query("QTART n=node(0) RETURN ID(n)")}.to raise_error(Neo4j::Session::CypherError)
    end
  end


end