module 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::reference {
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
        assert!(arg0 > 0 && arg1 > 0, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error::oracle_zero_price_error());
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
        assert!(arg1 > 0 && arg2 > 0, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error::oracle_zero_price_error());
        arg0.spot = arg1;
        arg0.ema = arg2;
        arg0.updated_at = arg3;
    }

    public(friend) fun updated_at(arg0: &AdminReference) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v6
}

