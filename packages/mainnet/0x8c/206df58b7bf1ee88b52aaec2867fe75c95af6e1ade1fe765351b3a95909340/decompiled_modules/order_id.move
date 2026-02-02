module 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::order_id {
    public fun order_id(arg0: u64, arg1: u64, arg2: bool) : u128 {
        if (arg2 == 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::ask()) {
            order_id_ask(arg0, arg1)
        } else {
            order_id_bid(arg0, arg1)
        }
    }

    public fun counter(arg0: u128) : u64 {
        ((arg0 & 18446744073709551615) as u64)
    }

    public fun is_ask(arg0: u128) : bool {
        arg0 < 170141183460469231731687303715884105728
    }

    public fun order_id_ask(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 < 9223372036854775808, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_price());
        (arg0 as u128) << 64 | (arg1 as u128)
    }

    public fun order_id_bid(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 < 9223372036854775808, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_price());
        ((arg0 ^ 18446744073709551615) as u128) << 64 | (arg1 as u128)
    }

    public fun price(arg0: u128) : u64 {
        if (is_ask(arg0)) {
            price_ask(arg0)
        } else {
            price_bid(arg0)
        }
    }

    public fun price_ask(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

    public fun price_bid(arg0: u128) : u64 {
        ((arg0 >> 64) as u64) ^ 18446744073709551615
    }

    // decompiled from Move bytecode v6
}

