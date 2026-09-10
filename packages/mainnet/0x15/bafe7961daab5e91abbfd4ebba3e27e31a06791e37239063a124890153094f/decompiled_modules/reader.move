module 0x15bafe7961daab5e91abbfd4ebba3e27e31a06791e37239063a124890153094f::reader {
    public fun current<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::fee_rate<T0, T1>(arg0), 1000000)
    }

    public fun economic_window_if<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun window_if<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, 0)
    }

    fun window_impl<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg3) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg2 > 0, 1);
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::first_score_for_swap(v0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        let v6 = 0;
        while (v5 < arg2 && 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::is_some(&v1)) {
            let (v7, v8) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::borrow_tick_for_swap(v0, 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::borrow(&v1), arg1);
            let v9 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::liquidity_net(v7);
            let v10 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::sqrt_price(v7);
            v6 = v10;
            0x1::vector::push_back<u128>(&mut v2, v10);
            0x1::vector::push_back<u128>(&mut v3, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i128::abs_u128(v9));
            0x1::vector::push_back<bool>(&mut v4, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i128::is_neg(v9));
            v1 = v8;
            v5 = v5 + 1;
            if (arg4 > 0) {
                let v11 = (v10 as u256) * (v10 as u256);
                if (arg1 && v11 <= arg4 || !arg1 && v11 >= arg4) {
                    break
                };
            };
        };
        let v12 = if (arg1) {
            0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::min_sqrt_price()
        } else {
            0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::max_sqrt_price()
        };
        if (!0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::is_some(&v1) && (v5 == 0 || v6 != v12)) {
            0x1::vector::push_back<u128>(&mut v2, v12);
            0x1::vector::push_back<u128>(&mut v3, 0);
            0x1::vector::push_back<bool>(&mut v4, false);
        };
        (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::liquidity<T0, T1>(arg0), v2, v3, v4)
    }

    // decompiled from Move bytecode v7
}

