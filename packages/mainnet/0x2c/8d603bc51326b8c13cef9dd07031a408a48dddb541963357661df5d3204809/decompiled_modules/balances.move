module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances {
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

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : Balances {
        Balances{
            base  : arg0,
            quote : arg1,
            deep  : arg2,
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

