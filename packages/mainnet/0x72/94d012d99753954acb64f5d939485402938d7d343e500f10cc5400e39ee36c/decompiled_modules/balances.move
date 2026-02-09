module 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balances {
    struct Balances has copy, drop, store {
        base: u64,
        quote: u64,
        deep: u64,
    }

    public(friend) fun empty() : Balances {
        Balances{
            base  : 0,
            quote : 0,
            deep  : 0,
        }
    }

    public(friend) fun add_balances(arg0: &mut Balances, arg1: Balances) {
        arg0.base = arg0.base + arg1.base;
        arg0.quote = arg0.quote + arg1.quote;
        arg0.deep = arg0.deep + arg1.deep;
    }

    public(friend) fun add_base(arg0: &mut Balances, arg1: u64) {
        arg0.base = arg0.base + arg1;
    }

    public(friend) fun add_deep(arg0: &mut Balances, arg1: u64) {
        arg0.deep = arg0.deep + arg1;
    }

    public(friend) fun add_quote(arg0: &mut Balances, arg1: u64) {
        arg0.quote = arg0.quote + arg1;
    }

    public(friend) fun base(arg0: &Balances) : u64 {
        arg0.base
    }

    public(friend) fun deep(arg0: &Balances) : u64 {
        arg0.deep
    }

    public(friend) fun mul(arg0: &mut Balances, arg1: u64) {
        arg0.base = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(arg0.base, arg1);
        arg0.quote = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(arg0.quote, arg1);
        arg0.deep = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(arg0.deep, arg1);
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : Balances {
        Balances{
            base  : arg0,
            quote : arg1,
            deep  : arg2,
        }
    }

    public(friend) fun non_zero_value(arg0: &Balances) : u64 {
        if (arg0.base > 0) {
            arg0.base
        } else if (arg0.quote > 0) {
            arg0.quote
        } else {
            arg0.deep
        }
    }

    public(friend) fun quote(arg0: &Balances) : u64 {
        arg0.quote
    }

    public(friend) fun reset(arg0: &mut Balances) : Balances {
        arg0.base = 0;
        arg0.quote = 0;
        arg0.deep = 0;
        *arg0
    }

    // decompiled from Move bytecode v6
}

