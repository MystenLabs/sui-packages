module 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference {
    struct AdminReference has store {
        spot: u64,
        ema: u64,
        updated_at: u64,
    }

    public(friend) fun ema(arg0: &AdminReference) : u64 {
        arg0.ema
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : AdminReference {
        assert!(arg0 > 0 && arg1 > 0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::oracle_zero_price_error());
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
        arg0.spot = arg1;
        arg0.ema = arg2;
        arg0.updated_at = arg3;
    }

    public(friend) fun updated_at(arg0: &AdminReference) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v7
}

