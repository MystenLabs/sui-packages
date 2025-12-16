module 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a5484a7b2caf45727 {
    struct Aac56ae4c64df67f8 has copy, drop {
        aef66ea9fdfdf6d38: address,
        ab48a9f34af22058d: u8,
        aa6e55145993bf678: u8,
        a4a765f8cdbb4cb81: u64,
        timestamp_ms: u64,
    }

    struct Af454e845b3b480b6 has copy, drop {
        aef66ea9fdfdf6d38: address,
        ab48a9f34af22058d: u8,
        aa6e55145993bf678: u8,
        a4a765f8cdbb4cb81: u64,
        a855e3b86142847f7: u64,
        aae7919b761f17521: u64,
        a6612e1531c0c2e43: u64,
        a3720faeda3b8d61f: u64,
        a976f6b7fea03909d: u64,
        a16ab7a833161a58e: u64,
        aab159116549728b8: u64,
        timestamp_ms: u64,
    }

    public(friend) fun a69080865752cb4f8(arg0: &0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u8, arg4: u8, arg5: address, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg14: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg18: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg20: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg21: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg22: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg23: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        if (arg3 != 10 || arg4 != 0) {
            let v0 = Aac56ae4c64df67f8{
                aef66ea9fdfdf6d38 : arg5,
                ab48a9f34af22058d : arg3,
                aa6e55145993bf678 : arg4,
                a4a765f8cdbb4cb81 : arg6,
                timestamp_ms      : 0x2::clock::timestamp_ms(arg24),
            };
            0x2::event::emit<Aac56ae4c64df67f8>(v0);
            return
        };
        let v1 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v2 = v1;
        let v3 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        let v4 = v3;
        let v5 = 0;
        if (v3 < arg6) {
            v5 = arg6 - v3;
        };
        if (v5 > 0) {
            let v6 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::ac89fc20276c7e30c(arg0, v5, arg2);
            let v7 = if (v6 < v1) {
                v6
            } else {
                v1
            };
            let v8 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a2ec4300f6df080d1::a099d08408fdb4a75(1);
            let (_, _) = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a2ec4300f6df080d1::af81a08da76e37dc0(&v8, arg1, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, v7, 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a2ec4300f6df080d1::a213fd2a6b463b66d(&v8, 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(&v8, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23), arg2 * 99 / 100), arg24, arg25);
            v4 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
            v2 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        };
        let v11 = if (v4 < arg6) {
            v4
        } else {
            arg6
        };
        let (v12, v13) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg24, arg8, arg7, arg3, arg9, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v11, arg25)), arg4, arg13, arg5, arg10, arg11, arg12, arg25);
        let v14 = v13;
        let v15 = v12;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v15, arg25), arg25);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v14, arg25), arg25);
        let v16 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v17 = 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        assert!(v17 + 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v16, arg2) >= v4 + 0x6a77d3dc634428cc98894fc3dd8684ca4f9c4317294008e4d3ebe35edcdbce15::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v2, arg2), 13906835213725466623);
        let v18 = Af454e845b3b480b6{
            aef66ea9fdfdf6d38 : arg5,
            ab48a9f34af22058d : arg3,
            aa6e55145993bf678 : arg4,
            a4a765f8cdbb4cb81 : arg6,
            a855e3b86142847f7 : v11 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v14),
            aae7919b761f17521 : 0x2::balance::value<0x2::sui::SUI>(&v15),
            a6612e1531c0c2e43 : v4,
            a3720faeda3b8d61f : v2,
            a976f6b7fea03909d : v17,
            a16ab7a833161a58e : v16,
            aab159116549728b8 : arg2,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg24),
        };
        0x2::event::emit<Af454e845b3b480b6>(v18);
    }

    // decompiled from Move bytecode v6
}

