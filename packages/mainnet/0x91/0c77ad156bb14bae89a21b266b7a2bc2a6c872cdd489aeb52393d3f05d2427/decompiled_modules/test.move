module 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::test {
    public fun find_prices<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: vector<vector<u64>>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T5, T6, T4>, arg4: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T7>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T8>) {
        let v0 = 0x1::vector::empty<0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::PriceNode>();
        0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::cetus::add_prices<T0, T1>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 0), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 0), 1), 0, arg1);
        0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::cetus::add_prices<T2, T3>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 1), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 1), 1), 1, arg2);
        0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::turbos::add_prices<T5, T6, T4>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 2), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 2), 1), 2, arg3);
        0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::af::add_prices<T7>(&mut v0, *0x1::vector::borrow<vector<u64>>(&arg0, 3), vector[vector[0, 1], vector[0, 2], vector[0, 3], vector[0, 4], vector[1, 0], vector[1, 2], vector[1, 3], vector[1, 4], vector[2, 0], vector[2, 1], vector[2, 3], vector[2, 4], vector[3, 0], vector[3, 1], vector[3, 2], vector[3, 4], vector[4, 0], vector[4, 1], vector[4, 2], vector[4, 3]], 3, arg4);
        0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::af::add_prices<T8>(&mut v0, *0x1::vector::borrow<vector<u64>>(&arg0, 4), vector[vector[0, 1], vector[1, 0]], 4, arg5);
        0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::emit_prices(v0);
    }

    public fun swap_route_new<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17>(arg0: vector<u16>, arg1: vector<u16>, arg2: vector<u16>, arg3: vector<u128>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T7, T8, T6>, arg8: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T9>, arg9: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T15>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg13: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg14: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg15: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg16: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0;
        let v1 = 0x2::bag::new(arg18);
        0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut v1, b"", arg4);
        while (v0 < 0x1::vector::length<u16>(&arg2)) {
            let v2 = *0x1::vector::borrow<u16>(&arg2, v0);
            if (v2 == 0) {
                0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::cetus::swap_bag<T2, T3>(&mut v1, arg5, *0x1::vector::borrow<u16>(&arg0, v0), arg10, arg17, arg18);
            } else if (v2 == 1) {
                0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::cetus::swap_bag<T4, T5>(&mut v1, arg6, *0x1::vector::borrow<u16>(&arg0, v0), arg10, arg17, arg18);
            } else if (v2 == 2) {
                0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::turbos::swap_bag<T6, T7, T8>(&mut v1, arg7, *0x1::vector::borrow<u16>(&arg0, v0), arg11, arg17, arg18);
            } else if (v2 == 3) {
                0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::af::swap_bag_5<T9, T10, T11, T12, T13, T14>(&mut v1, arg8, *0x1::vector::borrow<u16>(&arg0, v0), *0x1::vector::borrow<u16>(&arg1, v0), *0x1::vector::borrow<u128>(&arg3, v0), arg12, arg13, arg14, arg15, arg16, arg18);
            } else {
                assert!(v2 == 4, 9223373686122217471);
                0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::af::swap_bag<T15, T16, T17>(&mut v1, arg9, *0x1::vector::borrow<u16>(&arg0, v0), *0x1::vector::borrow<u16>(&arg1, v0), *0x1::vector::borrow<u128>(&arg3, v0), arg12, arg13, arg14, arg15, arg16, arg18);
            };
            v0 = v0 + 1;
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(&mut v1, b"")
    }

    // decompiled from Move bytecode v6
}

