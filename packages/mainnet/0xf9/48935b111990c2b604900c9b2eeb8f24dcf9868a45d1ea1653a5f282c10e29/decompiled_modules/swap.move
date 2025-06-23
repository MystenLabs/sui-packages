module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap {
    public fun add_swap_exact_in_to_route<T0, T1, T2, T3>(arg0: &0x2::object::UID, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::admin::is_authorized(arg0), 47);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::assert_correct_package(arg1);
        let v0 = 0x2::coin::value<T2>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T2>(arg3);
            return 0x2::coin::zero<T3>(arg5)
        };
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in_direct<T1, T2, T3>(arg2, v0);
        if (v1 > 0) {
            0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T1, T2>(arg2, arg3);
            let v3 = 0x1::vector::empty<0x1::ascii::String>();
            0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
            let v4 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v4, v0);
            let v5 = 0x1::vector::empty<0x1::ascii::String>();
            0x1::vector::push_back<0x1::ascii::String>(&mut v5, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
            let v6 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v6, v1);
            0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_swap_event<T1>(arg2, 0x2::tx_context::sender(arg5), 0x1::option::none<address>(), v3, v4, v5, v6, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T1>(arg2));
            0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::take<T1, T3>(arg2, v1, arg5)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg3, 0x2::tx_context::sender(arg5));
            0x2::coin::zero<T3>(arg5)
        }
    }

    public fun add_swap_exact_out_to_route<T0, T1, T2, T3>(arg0: &0x2::object::UID, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>, arg3: u64, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::admin::is_authorized(arg0), 47);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::assert_correct_package(arg1);
        if (arg3 == 0) {
            return 0x2::coin::zero<T3>(arg6)
        };
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_out_direct<T1, T2, T3>(arg2, arg3);
        assert!(v0 <= 0x2::coin::value<T2>(arg4), 44);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T1, T2>(arg2, 0x2::coin::split<T2>(arg4, v0, arg6));
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, v0);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, arg3);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_swap_event<T1>(arg2, 0x2::tx_context::sender(arg6), 0x1::option::none<address>(), v1, v2, v3, v4, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T1>(arg2));
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::take<T1, T3>(arg2, arg3, arg6)
    }

    public fun swap_exact_in<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        swap_exact_in_direct<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(arg7, 1000000000000000000 - arg8), arg9)
    }

    public fun swap_exact_in_direct<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::assert_correct_package(arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg8);
        let v1 = 0x2::coin::value<T1>(&arg6);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T1>(arg6);
            return 0x2::coin::zero<T2>(arg8)
        };
        let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in_direct<T0, T1, T2>(arg0, v1);
        assert!(v2 >= arg7, 48);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, v1);
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v5, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v2);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_swap_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v3, v4, v5, v6, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg0));
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::take<T0, T2>(arg0, v2, arg8)
    }

    public fun swap_exact_out<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = if (arg9 >= 1000000000000000000) {
            18446744073709551615
        } else {
            let v1 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down_128((arg8 as u128), ((1000000000000000000 - arg9) as u128));
            if (v1 >= (18446744073709551615 as u128)) {
                18446744073709551615
            } else {
                (v1 as u64)
            }
        };
        swap_exact_out_direct<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg10)
    }

    public fun swap_exact_out_direct<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::assert_correct_package(arg1);
        let v0 = 0x2::tx_context::sender(arg9);
        if (arg6 == 0) {
            return 0x2::coin::zero<T2>(arg9)
        };
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_out_direct<T0, T1, T2>(arg0, arg6);
        let v2 = 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::minimum_before_fees(arg2, v1);
        assert!(v2 <= arg8, 48);
        assert!(v2 <= 0x2::coin::value<T1>(arg7), 44);
        let v3 = 0x2::coin::split<T1>(arg7, v2, arg9);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v3, v0, arg9);
        assert!(0x2::coin::value<T1>(&v3) >= v1, 46);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, v3);
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v4, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, v1);
        let v6 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v6, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        let v7 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v7, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_swap_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v4, v5, v6, v7, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg0));
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::take<T0, T2>(arg0, arg6, arg9)
    }

    // decompiled from Move bytecode v6
}

