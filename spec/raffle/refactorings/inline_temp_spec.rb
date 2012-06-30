require 'ripper'
require 'sorcerer'
require 'awesome_print'
require_relative '../../../lib/raffle/refactorings/inline_temp'

describe Raffle::Refactorings::InlineTemp do
  it 'returns an s-expression with the temp inlined' do
    src = 'def thing;
    fred = 35
    june = fred
    end'
    sexp = convert(src)
    result = subject.call(sexp, "fred")
    rubify(result).should == 'def thing fred = 35; june = 35; end'
  end

  def convert(source)
    pp Ripper.sexp(source)
    pp '-----------'
    Ripper::SexpBuilder.new(source).parse
  end

  def rubify(sexpr)
    Sorcerer.source(sexpr)
  end
end
