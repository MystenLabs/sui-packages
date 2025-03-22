module 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::swap {
    struct SwapEvent has copy, drop {
        sender: address,
        pool_id: address,
        coin_in_type: 0x1::string::String,
        coin_out_type: 0x1::string::String,
        amount_in: u64,
        amount_out: u64,
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::epoch(arg4) <= arg3, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2) = 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_reserves<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        let v3 = (v0 as u128) * (10000 - (0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_fee_percent<T0, T1>(arg0) as u128));
        let v4 = v3 * (v2 as u128) / ((v1 as u128) * 10000 + v3);
        let v5 = if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v4 as u64)
        };
        assert!(v5 >= arg2, 1);
        let v6 = SwapEvent{
            sender        : 0x2::tx_context::sender(arg4),
            pool_id       : 0x2::object::uid_to_address(0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_pool_id<T0, T1>(arg0)),
            coin_in_type  : get_coin_name<T0>(),
            coin_out_type : get_coin_name<T1>(),
            amount_in     : v0,
            amount_out    : v5,
        };
        0x2::event::emit<SwapEvent>(v6);
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::swap_x_to_y<T0, T1>(arg0, arg1, v5, arg4)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::epoch(arg4) <= arg3, 3);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2) = 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_reserves<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        let v3 = (v0 as u128) * (10000 - (0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_fee_percent<T0, T1>(arg0) as u128));
        let v4 = v3 * (v1 as u128) / ((v2 as u128) * 10000 + v3);
        let v5 = if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v4 as u64)
        };
        assert!(v5 >= arg2, 1);
        let v6 = SwapEvent{
            sender        : 0x2::tx_context::sender(arg4),
            pool_id       : 0x2::object::uid_to_address(0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_pool_id<T0, T1>(arg0)),
            coin_in_type  : get_coin_name<T1>(),
            coin_out_type : get_coin_name<T0>(),
            amount_in     : v0,
            amount_out    : v5,
        };
        0x2::event::emit<SwapEvent>(v6);
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::swap_y_to_x<T0, T1>(arg0, arg1, v5, arg4)
    }

    fun get_coin_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    // decompiled from Move bytecode v6
}

