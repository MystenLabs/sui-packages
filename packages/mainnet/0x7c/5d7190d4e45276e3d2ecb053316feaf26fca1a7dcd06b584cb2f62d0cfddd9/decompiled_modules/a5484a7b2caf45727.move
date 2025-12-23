module 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a5484a7b2caf45727 {
    struct Aac56ae4c64df67f8 has copy, drop {
        aef66ea9fdfdf6d38: address,
        ab48a9f34af22058d: u8,
        aa6e55145993bf678: u8,
        a336ab9dffa65c9af: bool,
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

    struct Ae5618fec1f8e816b has copy, drop {
        ae9ea603231b993f7: address,
        a884fe2d741a55d6d: vector<u8>,
        ac1de6c9b6c718861: vector<u256>,
        a33e0038d6ac161bf: vector<u8>,
        a0ada78908f255730: vector<u256>,
    }

    public(friend) fun a69080865752cb4f8(arg0: &0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u8, arg4: u8, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg13: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg19: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg20: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg21: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg22: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg23, arg7, arg6, arg5);
        let v1 = if (v0) {
            let (v2, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg6, arg3);
            ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg23, arg7, arg6, arg4, arg5) * v2 / 1000000000000000000000000000 * 1000000000 / 1000000) as u64)
        } else {
            0
        };
        let v5 = Aac56ae4c64df67f8{
            aef66ea9fdfdf6d38 : arg5,
            ab48a9f34af22058d : arg3,
            aa6e55145993bf678 : arg4,
            a336ab9dffa65c9af : v0,
            a4a765f8cdbb4cb81 : v1,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg23),
        };
        0x2::event::emit<Aac56ae4c64df67f8>(v5);
        if (!v0 || v1 == 0) {
            return
        };
        if (arg3 != 10 || arg4 != 0) {
            return
        };
        let v6 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v7 = v6;
        let v8 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        let v9 = v8;
        let v10 = 0;
        if (v8 < v1) {
            v10 = v1 - v8;
        };
        if (v10 > 0) {
            let v11 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::ac89fc20276c7e30c(arg0, v10, arg2);
            let v12 = if (v11 < v6) {
                v11
            } else {
                v6
            };
            let v13 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a2ec4300f6df080d1::a099d08408fdb4a75(1);
            let (_, _) = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a2ec4300f6df080d1::af81a08da76e37dc0(&v13, arg1, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, v12, 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a2ec4300f6df080d1::a213fd2a6b463b66d(&v13, 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(&v13, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22), arg2 * 99 / 100), arg23, arg24);
            v9 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
            v7 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        };
        let v16 = if (v9 < v1) {
            v9
        } else {
            v1
        };
        let (v17, v18) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg23, arg7, arg6, arg3, arg8, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v16, arg24)), arg4, arg12, arg5, arg9, arg10, arg11, arg24);
        let v19 = v18;
        let v20 = v17;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v20, arg24), arg24);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v19, arg24), arg24);
        let v21 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v22 = 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1);
        assert!(v22 + 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v21, arg2) >= v9 + 0x7c5d7190d4e45276e3d2ecb053316feaf26fca1a7dcd06b584cb2f62d0cfddd9::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v7, arg2), 13906835368344289279);
        let v23 = Af454e845b3b480b6{
            aef66ea9fdfdf6d38 : arg5,
            ab48a9f34af22058d : arg3,
            aa6e55145993bf678 : arg4,
            a4a765f8cdbb4cb81 : v1,
            a855e3b86142847f7 : v16 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v19),
            aae7919b761f17521 : 0x2::balance::value<0x2::sui::SUI>(&v20),
            a6612e1531c0c2e43 : v9,
            a3720faeda3b8d61f : v7,
            a976f6b7fea03909d : v22,
            a16ab7a833161a58e : v21,
            aab159116549728b8 : arg2,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg23),
        };
        0x2::event::emit<Af454e845b3b480b6>(v23);
    }

    public fun a71a3c2cbe8aac741(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (vector<Ae5618fec1f8e816b>, u64) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<Ae5618fec1f8e816b>();
        while (v0 < 0x1::vector::length<address>(&arg2) && v0 < arg4) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            v0 = v0 + 1;
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, v2);
            let v5 = v4;
            let v6 = v3;
            let v7 = 0;
            0x1::vector::reverse<u8>(&mut v5);
            let v8 = 0;
            while (v8 < 0x1::vector::length<u8>(&v5)) {
                let v9 = 0x1::vector::pop_back<u8>(&mut v5);
                let (_, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v9, v2);
                let (_, v13, v14) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg5, arg1, v9);
                v7 = v7 + ((v11 * v13 / (0x2::math::pow(10, v14) as u256) * 1000000 / 1000000000000000000000000000) as u64);
                v8 = v8 + 1;
            };
            0x1::vector::destroy_empty<u8>(v5);
            if (v7 < arg3) {
                continue
            };
            let v15 = vector[];
            let v16 = vector[];
            let v17 = &v6;
            let v18 = 0;
            while (v18 < 0x1::vector::length<u8>(v17)) {
                let (v19, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, *0x1::vector::borrow<u8>(v17, v18), v2);
                0x1::vector::push_back<u256>(&mut v15, v19);
                v18 = v18 + 1;
            };
            let v21 = &v5;
            let v22 = 0;
            while (v22 < 0x1::vector::length<u8>(v21)) {
                let (_, v24) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, *0x1::vector::borrow<u8>(v21, v22), v2);
                0x1::vector::push_back<u256>(&mut v16, v24);
                v22 = v22 + 1;
            };
            let v25 = Ae5618fec1f8e816b{
                ae9ea603231b993f7 : v2,
                a884fe2d741a55d6d : v6,
                ac1de6c9b6c718861 : v15,
                a33e0038d6ac161bf : v5,
                a0ada78908f255730 : v16,
            };
            0x1::vector::push_back<Ae5618fec1f8e816b>(&mut v1, v25);
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

