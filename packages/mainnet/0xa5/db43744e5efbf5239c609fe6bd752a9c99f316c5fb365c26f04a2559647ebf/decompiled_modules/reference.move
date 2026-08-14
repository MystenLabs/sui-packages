module 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference {
    struct AdminReference has store {
        spot: u64,
        ema: u64,
        updated_at: u64,
    }

    public(friend) fun destroy(arg0: AdminReference) {
        let AdminReference {
            spot       : _,
            ema        : _,
            updated_at : _,
        } = arg0;
    }

    public(friend) fun ema(arg0: &AdminReference) : u64 {
        arg0.ema
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : AdminReference {
        assert!(arg0 > 0 && arg1 > 0, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_error::oracle_zero_price_error());
        AdminReference{
            spot       : arg0,
            ema        : arg1,
            updated_at : arg2,
        }
    }

    public(friend) fun spot(arg0: &AdminReference) : u64 {
        arg0.spot
    }

    public(friend) fun update(arg0: &mut AdminReference, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0 && arg2 > 0, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_error::oracle_zero_price_error());
        arg0.spot = arg1;
        arg0.ema = arg2;
        arg0.updated_at = arg3;
    }

    public(friend) fun updated_at(arg0: &AdminReference) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v6
}

