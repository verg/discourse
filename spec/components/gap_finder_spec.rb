require 'spec_helper'
require 'cache'

describe GapFinder do

  it 'returns no gaps for empty data' do
    GapFinder.find(nil, nil).should be_nil
  end

  it 'returns no gaps with one element' do
    GapFinder.find([1], [1]).should be_nil
  end

  it 'returns no gaps when all elements are present' do
    GapFinder.find([1,2,3], [1,2,3]).should be_nil
  end

  it 'returns a single element gap' do
    GapFinder.find([1,3], [1,2,3]).should == {3 => [2]}
  end

  it 'returns a gap when one is present' do
    GapFinder.find([1,2,3,6,7], [1,2,3,4,5,6,7]).should == {6 => [4, 5]}
  end

  it 'returns multiple gaps' do
    GapFinder.find([1,5,6,7,10], [1,2,3,4,5,6,7,8,9,10]).should == {5 => [2,3,4], 10 => [8, 9]}
  end

  it 'returns a gap in the beginning' do
    GapFinder.find([2,3,4], [1,2,3,4]).should == {2 => [1]}
  end

  it 'returns a gap in the ending' do
    GapFinder.find([1,2,3], [1,2,3,4]).should == {4 => [4]}
  end

  it 'returns a large gap in the ending' do
    GapFinder.find([1,2,3], [1,2,3,4,5,6]).should == {6 => [4,5,6]}
  end

end
