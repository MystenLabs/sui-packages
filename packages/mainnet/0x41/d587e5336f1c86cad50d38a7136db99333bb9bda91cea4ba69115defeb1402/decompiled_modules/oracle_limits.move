module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits {
    struct OracleLimits has copy, drop, store {
        min_price: u64,
        max_price: u64,
        max_age_ms: u64,
    }

    public(friend) fun max_age_ms(arg0: &OracleLimits) : u64 {
        arg0.max_age_ms
    }

    public(friend) fun max_price(arg0: &OracleLimits) : u64 {
        arg0.max_price
    }

    public(friend) fun min_price(arg0: &OracleLimits) : u64 {
        arg0.min_price
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : OracleLimits {
        let v0 = OracleLimits{
            min_price  : arg0,
            max_price  : arg1,
            max_age_ms : arg2,
        };
        validate(&v0);
        v0
    }

    public(friend) fun set_max_age_ms(arg0: &mut OracleLimits, arg1: u64) {
        arg0.max_age_ms = arg1;
        validate(arg0);
    }

    public(friend) fun set_max_price(arg0: &mut OracleLimits, arg1: u64) {
        arg0.max_price = arg1;
        validate(arg0);
    }

    public(friend) fun set_min_price(arg0: &mut OracleLimits, arg1: u64) {
        arg0.min_price = arg1;
        validate(arg0);
    }

    public(friend) fun validate(arg0: &OracleLimits) {
        assert!(arg0.min_price > 0, 13835339753597173761);
        assert!(arg0.max_price > arg0.min_price, 13835339757892141057);
        assert!(arg0.max_age_ms <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_oracle_age_ms() && arg0.max_age_ms > 0, 13835339770777042945);
    }

    // decompiled from Move bytecode v6
}

