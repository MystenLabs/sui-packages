module 0x6d1a652e1253625b2004838e935e53b7f98b8347889161f681ba152e65dfed08::weighted {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun net_input(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg2: address, arg3: u64) : u64 {
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(arg3, 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::total_protocol_fee(arg0));
        let v1 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(v0, 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::treasury_fee(arg0));
        let v2 = if (0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::has_referrer(arg1, arg2)) {
            0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(v1, 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::referee_discount(arg0))
        } else {
            0
        };
        arg3 - v1 - v2 - 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(v0, 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::insurance_fund_fee(arg0)) - 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(v0, 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::dev_wallet_fee(arg0))
    }

    public fun quote_aftermath<T0, T1, T2, T3, T4>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>>(arg2);
        let v1 = if (arg5) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg6, arg7)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg6, arg7)
        };
        let v4 = net_input(arg3, arg4, 0x2::tx_context::sender(arg9), v1);
        assert!(arg8 > 0, 0);
        let v5 = if (v4 == 0) {
            0
        } else if (arg5) {
            0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T4, T2, T3>(arg2, v4, arg8, 1000000000000000000)
        } else {
            0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T4, T3, T2>(arg2, v4, arg8, 1000000000000000000)
        };
        if (arg5) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v6, 7, v0, arg5, v1, v5, v5 > 0);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v7, 7, v0, arg5, v1, v5, v5 > 0);
        };
    }

    public fun swap_aftermath<T0, T1, T2, T3, T4>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: bool, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8) {
            let v0 = Witness{dummy_field: false};
            let v1 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v0, 7, 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>>(arg2), true, arg10);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v1)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v1);
                return
            };
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T4, T2, T3>(arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v1), arg9, 1000000000000000000, arg10));
        } else {
            let v3 = Witness{dummy_field: false};
            let v4 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v3, 7, 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>>(arg2), false, arg10);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v4)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v4);
                return
            };
            let v5 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v5, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T4, T3, T2>(arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v4), arg9, 1000000000000000000, arg10));
        };
    }

    // decompiled from Move bytecode v7
}

