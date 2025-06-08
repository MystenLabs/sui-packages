module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee {
    struct Fee<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee: u32,
        tick_spacing: u32,
    }

    public fun create_fee<T0: drop>(arg0: T0, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : Fee<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        Fee<T0>{
            id           : 0x2::object::new(arg3),
            fee          : arg1,
            tick_spacing : arg2,
        }
    }

    public fun get_fee<T0>(arg0: &Fee<T0>) : u32 {
        arg0.fee
    }

    public fun get_tick_spacing<T0>(arg0: &Fee<T0>) : u32 {
        arg0.tick_spacing
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

