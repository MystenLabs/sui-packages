module 0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::helper {
    public(friend) fun apply_slippage(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        arg0 + 0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::mul(arg0, arg1)
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
            0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::mul(arg0, arg1)
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

