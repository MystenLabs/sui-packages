module 0xdf4a02964a418b406504ecd8fa976025df14022e6c6f4b544372e9098c6395b::helper {
    public(friend) fun apply_slippage(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        arg0 + 0xdf4a02964a418b406504ecd8fa976025df14022e6c6f4b544372e9098c6395b::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_deep_required<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (is_pool_whitelisted<T0, T1>(arg0)) {
            0
        } else {
            let (v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, arg1, arg2);
            apply_slippage(v1, 100000000)
        }
    }

    public(friend) fun calculate_order_amount(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xdf4a02964a418b406504ecd8fa976025df14022e6c6f4b544372e9098c6395b::math::mul(arg0, arg1)
        } else {
            arg0
        }
    }

    public(friend) fun get_fee_bps<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        v0
    }

    public(friend) fun get_order_deep_price_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : (bool, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v0))
    }

    public(friend) fun get_sui_per_deep<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0) && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::registered_pool<T0, T1>(arg0), 9223372578020720642);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v3 = 0x1::type_name::get<0x2::sui::SUI>();
        assert!(v0 == v2 && v1 == v3 || v0 == v3 && v1 == v2, 9223372629560328194);
        if (v0 == v2) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1)
        } else {
            0xdf4a02964a418b406504ecd8fa976025df14022e6c6f4b544372e9098c6395b::math::div(1000000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1))
        }
    }

    public(friend) fun is_pool_whitelisted<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : bool {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)
    }

    public(friend) fun transfer_if_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

