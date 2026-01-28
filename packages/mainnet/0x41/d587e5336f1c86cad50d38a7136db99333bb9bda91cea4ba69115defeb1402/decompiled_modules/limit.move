module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit {
    struct Limit has copy, drop, store {
        max_mint: u64,
        max_redeem: u64,
    }

    public fun max_mint(arg0: &Limit) : u64 {
        arg0.max_mint
    }

    public fun max_redeem(arg0: &Limit) : u64 {
        arg0.max_redeem
    }

    public fun new(arg0: u64, arg1: u64) : Limit {
        Limit{
            max_mint   : arg0,
            max_redeem : arg1,
        }
    }

    public fun set_max_mint(arg0: &mut Limit, arg1: u64) {
        arg0.max_mint = arg1;
    }

    public fun set_max_redeem(arg0: &mut Limit, arg1: u64) {
        arg0.max_redeem = arg1;
    }

    // decompiled from Move bytecode v6
}

