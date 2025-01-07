module 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::af {
    public(friend) fun swap<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6, arg7, arg1, arg2, 500000000000000000, arg8)
    }

    public(friend) fun add_prices<T0>(arg0: &mut vector<0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::PriceNode>, arg1: vector<u64>, arg2: vector<vector<u64>>, arg3: u16, arg4: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>) {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in<T0>(arg4);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out<T0>(arg4);
        let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg4);
        let v3 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg4);
        0x1::vector::reverse<vector<u64>>(&mut arg2);
        while (0x1::vector::length<vector<u64>>(&arg2) != 0) {
            let v4 = 0x1::vector::pop_back<vector<u64>>(&mut arg2);
            0x1::vector::push_back<0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::PriceNode>(arg0, 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::new_price_node(*0x1::vector::borrow<u64>(&arg1, *0x1::vector::borrow<u64>(&v4, 0)), *0x1::vector::borrow<u64>(&arg1, *0x1::vector::borrow<u64>(&v4, 1)), arg3, 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::sqrt_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::to_128(*0x1::vector::borrow<u64>(&v2, *0x1::vector::borrow<u64>(&v4, 1))) / (*0x1::vector::borrow<u64>(&v2, *0x1::vector::borrow<u64>(&v4, 0)) as u128), 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::to_128(*0x1::vector::borrow<u64>(&v3, *0x1::vector::borrow<u64>(&v4, 0))) / (*0x1::vector::borrow<u64>(&v3, *0x1::vector::borrow<u64>(&v4, 1)) as u128))), 18446744073709551616 - 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::to_128(*0x1::vector::borrow<u64>(&v0, *0x1::vector::borrow<u64>(&v4, 0)) + *0x1::vector::borrow<u64>(&v1, *0x1::vector::borrow<u64>(&v4, 1))) / 1000000000000000000)));
        };
        0x1::vector::destroy_empty<vector<u64>>(arg2);
    }

    public(friend) fun swap_bag<T0, T1, T2>(arg0: &mut 0x2::bag::Bag, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: u16, arg3: u16, arg4: u128, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            let v0 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"");
            assert!(arg3 == 1, 9223372320322617343);
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T1, T2>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
        } else {
            assert!(arg2 == 1, 9223372384747126783);
            let v1 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"");
            assert!(arg3 == 0, 9223372367567257599);
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T2, T1>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
        };
    }

    public(friend) fun swap_bag_3<T0, T1, T2, T3>(arg0: &mut 0x2::bag::Bag, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: u16, arg3: u16, arg4: u128, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            let v0 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"");
            if (arg3 == 1) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T1, T2>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 2, 9223372509301178367);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"", swap<T0, T1, T3>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        } else if (arg2 == 1) {
            let v1 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"");
            if (arg3 == 0) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T2, T1>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 2, 9223372573725687807);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"", swap<T0, T2, T3>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        } else {
            assert!(arg2 == 2, 9223372655330066431);
            let v2 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"");
            if (arg3 == 0) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T3, T1>(arg1, v2, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T3>(&v2) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 1, 9223372638150197247);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T3, T2>(arg1, v2, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T3>(&v2) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        };
    }

    public(friend) fun swap_bag_5<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x2::bag::Bag, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: u16, arg3: u16, arg4: u128, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            let v0 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"");
            if (arg3 == 1) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T1, T2>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 2) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"", swap<T0, T1, T3>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 3) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T4>>(arg0, b"", swap<T0, T1, T4>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 4, 9223372814243856383);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T5>>(arg0, b"", swap<T0, T1, T5>(arg1, v0, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T1>(&v0) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        } else if (arg2 == 1) {
            let v1 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"");
            if (arg3 == 0) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T2, T1>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 2) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"", swap<T0, T2, T3>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 3) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T4>>(arg0, b"", swap<T0, T2, T4>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 4, 9223372913028104191);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T5>>(arg0, b"", swap<T0, T2, T5>(arg1, v1, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T2>(&v1) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        } else if (arg2 == 2) {
            let v2 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"");
            if (arg3 == 0) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T3, T1>(arg1, v2, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T3>(&v2) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 1) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T3, T2>(arg1, v2, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T3>(&v2) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 3) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T4>>(arg0, b"", swap<T0, T3, T4>(arg1, v2, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T3>(&v2) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 4, 9223373011812351999);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T5>>(arg0, b"", swap<T0, T3, T5>(arg1, v2, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T3>(&v2) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        } else if (arg2 == 3) {
            let v3 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T4>>(arg0, b"");
            if (arg3 == 0) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T4, T1>(arg1, v3, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T4>(&v3) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 1) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T4, T2>(arg1, v3, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T4>(&v3) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 2) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"", swap<T0, T4, T3>(arg1, v3, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T4>(&v3) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 4, 9223373110596599807);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T5>>(arg0, b"", swap<T0, T4, T5>(arg1, v3, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T4>(&v3) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        } else {
            assert!(arg2 == 4, 9223373226560716799);
            let v4 = 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T5>>(arg0, b"");
            if (arg3 == 0) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap<T0, T5, T1>(arg1, v4, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T5>(&v4) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 1) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap<T0, T5, T2>(arg1, v4, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T5>(&v4) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else if (arg3 == 2) {
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T3>>(arg0, b"", swap<T0, T5, T3>(arg1, v4, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T5>(&v4) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            } else {
                assert!(arg3 == 3, 9223373209380847615);
                0x2::bag::add<vector<u8>, 0x2::coin::Coin<T4>>(arg0, b"", swap<T0, T5, T4>(arg1, v4, (0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(arg4, arg4), (0x2::coin::value<T5>(&v4) as u128)) as u64), arg5, arg6, arg7, arg8, arg9, arg10));
            };
        };
    }

    // decompiled from Move bytecode v6
}

