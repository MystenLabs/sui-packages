module 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events {
    struct SwapPotato {
        type_in: vector<u8>,
        amount_in: u64,
        type_out: vector<u8>,
        amount_out: u64,
        referrer: 0x1::option::Option<address>,
        router_fee: 0x1::option::Option<u64>,
        router_fee_recipient: 0x1::option::Option<address>,
    }

    struct SwapCompletedEvent has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        referrer: 0x1::option::Option<address>,
        router_fee: 0x1::option::Option<u64>,
        router_fee_recipient: 0x1::option::Option<address>,
    }

    public fun bake_potato(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<address>) : SwapPotato {
        SwapPotato{
            type_in              : arg0,
            amount_in            : 0,
            type_out             : arg1,
            amount_out           : 0,
            referrer             : arg2,
            router_fee           : arg3,
            router_fee_recipient : arg4,
        }
    }

    fun is_same_type<T0>(arg0: &vector<u8>) : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0));
        let v2 = 0x1::vector::length<u8>(arg0);
        if (v2 != 0x1::vector::length<u8>(v1)) {
            return false
        };
        while (v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            if (*0x1::vector::borrow<u8>(arg0, v3) != *0x1::vector::borrow<u8>(v1, v3)) {
                return false
            };
        };
        true
    }

    public fun try_add_trade_to_potato<T0, T1>(arg0: &mut SwapPotato, arg1: bool, arg2: bool, arg3: u64, arg4: u64) {
        if (arg1 && is_same_type<T0>(&arg0.type_in)) {
            arg0.amount_in = arg0.amount_in + arg3;
        };
        if (arg2 && is_same_type<T1>(&arg0.type_out)) {
            arg0.amount_out = arg0.amount_out + arg4;
        };
    }

    public fun try_consume_potato(arg0: SwapPotato, arg1: address, arg2: u64) {
        assert!(arg0.amount_out >= arg2, 0);
        assert!(arg0.amount_in > 0 && arg0.amount_out > 0, 1);
        let SwapPotato {
            type_in              : v0,
            amount_in            : v1,
            type_out             : v2,
            amount_out           : v3,
            referrer             : v4,
            router_fee           : v5,
            router_fee_recipient : v6,
        } = arg0;
        let v7 = SwapCompletedEvent{
            swapper              : arg1,
            type_in              : 0x1::ascii::string(v0),
            amount_in            : v1,
            type_out             : 0x1::ascii::string(v2),
            amount_out           : v3,
            referrer             : v4,
            router_fee           : v5,
            router_fee_recipient : v6,
        };
        0x2::event::emit<SwapCompletedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

