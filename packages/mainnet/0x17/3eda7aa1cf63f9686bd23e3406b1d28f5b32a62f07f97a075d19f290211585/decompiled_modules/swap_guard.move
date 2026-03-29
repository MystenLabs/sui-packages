module 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::swap_guard {
    struct SwapVerifiedEvent has copy, drop {
        input_amount: u64,
        output_amount: u64,
        input_decimals: u8,
        output_decimals: u8,
        slippage_bps: u64,
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify_swap<T0>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::crank::CrankConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg8: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg9: vector<u8>, arg10: vector<u8>) {
        assert!(arg3 > 0, 1002);
        assert!(arg5 <= 18 && arg6 <= 18, 1001);
        let v0 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_info_from_price_info_object(arg7);
        let v1 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_identifier(&v0);
        assert!(0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_identifier::get_bytes(&v1) == arg9, 1004);
        let v2 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_info_from_price_info_object(arg8);
        let v3 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_identifier(&v2);
        assert!(0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_identifier::get_bytes(&v3) == arg10, 1004);
        let v4 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::pyth::get_price_no_older_than(arg7, arg2, 60);
        let v5 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_price(&v4);
        let v6 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_expo(&v4);
        let v7 = (0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_positive(&v5) as u256);
        if (!0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::is_depeg_active<T0>(arg0)) {
            assert!((0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_conf(&v4) as u256) * 100 <= v7 * 2, 1003);
        };
        let v8 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::pyth::get_price_no_older_than(arg8, arg2, 60);
        let v9 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_price(&v8);
        let v10 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_expo(&v8);
        let v11 = (0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_positive(&v9) as u256);
        if (!0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::is_depeg_active<T0>(arg0)) {
            assert!((0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_conf(&v8) as u256) * 100 <= v11 * 2, 1003);
        };
        let v12 = (arg3 as u256) * v7 * pow10(arg6) * pow10((0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_negative(&v10) as u8));
        let v13 = (arg4 as u256) * v11 * pow10(arg5) * pow10((0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_negative(&v6) as u8));
        assert!(v13 >= v12 / 10000 * (10000 - (0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::crank::max_swap_slippage_bps(arg1) as u256)), 1000);
        let v14 = if (v13 >= v12) {
            0
        } else {
            (((v12 - v13) * 10000 / v12) as u64)
        };
        let v15 = SwapVerifiedEvent{
            input_amount    : arg3,
            output_amount   : arg4,
            input_decimals  : arg5,
            output_decimals : arg6,
            slippage_bps    : v14,
        };
        0x2::event::emit<SwapVerifiedEvent>(v15);
    }

    public fun verify_usdb_to_usdc<T0>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::crank::CrankConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg6: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject) {
        verify_swap<T0>(arg0, arg1, arg2, arg3, arg4, 9, 6, arg5, arg6, x"f85d863ce3b640bf85307be333dedc563aa3a27961c9042f89ed8300ebd3c855", x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a");
    }

    public fun verify_usdc_to_usdb<T0>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::crank::CrankConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg6: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject) {
        verify_swap<T0>(arg0, arg1, arg2, arg3, arg4, 6, 9, arg5, arg6, x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", x"f85d863ce3b640bf85307be333dedc563aa3a27961c9042f89ed8300ebd3c855");
    }

    public fun verify_usdc_to_usdsui<T0>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::crank::CrankConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg6: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject) {
        verify_swap<T0>(arg0, arg1, arg2, arg3, arg4, 6, 9, arg5, arg6, x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", x"d9912df360b5b7f21a122f15bdd5e27f62ce5e72bd316c291f7c86620e07fb2a");
    }

    public fun verify_usdsui_to_usdc<T0>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::crank::CrankConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg6: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject) {
        verify_swap<T0>(arg0, arg1, arg2, arg3, arg4, 9, 6, arg5, arg6, x"d9912df360b5b7f21a122f15bdd5e27f62ce5e72bd316c291f7c86620e07fb2a", x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a");
    }

    // decompiled from Move bytecode v6
}

