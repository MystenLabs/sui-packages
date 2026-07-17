module 0x840502a5ec983125ef5793b2231d3e7d8c92d2ad1cbdf3e3aa46a6088dfe2596::executor {
    struct ArbitrageExecuted has copy, drop {
        route_hash: vector<u8>,
        profit_amount: u64,
        profit_coin_type: vector<u8>,
        recipient: address,
    }

    fun new_event<T0>(arg0: vector<u8>, arg1: u64, arg2: address) : ArbitrageExecuted {
        ArbitrageExecuted{
            route_hash       : arg0,
            profit_amount    : arg1,
            profit_coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            recipient        : arg2,
        }
    }

    public fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<u8>, arg3: address) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 0);
        0x2::event::emit<ArbitrageExecuted>(new_event<T0>(arg2, v0, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
    }

    // decompiled from Move bytecode v7
}

