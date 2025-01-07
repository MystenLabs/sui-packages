module 0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::incentive_getter {
    struct IncentivePoolInfo has copy, drop {
        pool_id: address,
        funds: address,
        phase: u64,
        start_at: u64,
        end_at: u64,
        closed_at: u64,
        total_supply: u64,
        asset_id: u8,
        option: u8,
        factor: u256,
        distributed: u64,
        available: u256,
        total: u256,
    }

    struct IncentiveAPYInfo has copy, drop {
        asset_id: u8,
        apy: u256,
        coin_types: vector<0x1::ascii::String>,
    }

    struct IncentivePoolInfoByPhase has copy, drop {
        phase: u64,
        pools: vector<IncentivePoolInfo>,
    }

    public fun get_incentive_apy(arg0: &0x2::clock::Clock, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: u8) : vector<IncentiveAPYInfo> {
        let v0 = 0x1::vector::empty<IncentiveAPYInfo>();
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg2);
        while (v1 > 0) {
            let v2 = v1 - 1;
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg2, v2);
            let v5 = v3;
            if (arg4 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()) {
                v5 = v4;
            };
            let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_active_pools(arg1, v2, arg4, 0x2::clock::timestamp_ms(arg0));
            let v7 = 0x1::vector::length<address>(&v6);
            if (v7 == 0) {
                v1 = v1 - 1;
                continue
            };
            let v8 = 0;
            let v9 = 0x1::vector::empty<0x1::ascii::String>();
            while (v7 > 0) {
                let (_, _, v12, v13, v14, _, v16, _, _, _, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_info(arg1, *0x1::vector::borrow<address>(&v6, v7 - 1));
                let (_, v24, v25) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_funds_info(arg1, v12);
                let (_, _, v28) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg3, v24);
                v8 = v8 + 0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::ray_math::ray_div(0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::ray_math::ray_mul(0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::ray_math::ray_div(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::convert_amount(v16, v28, 9) as u256), v24), ((v14 - v13) as u256)), (31536000000 as u256)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg3, v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, v2)));
                let v29 = 0x1::type_name::into_string(v25);
                if (!0x1::vector::contains<0x1::ascii::String>(&v9, &v29)) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v9, 0x1::type_name::into_string(v25));
                };
                v7 = v7 - 1;
            };
            let v30 = IncentiveAPYInfo{
                asset_id   : v2,
                apy        : v8,
                coin_types : v9,
            };
            0x1::vector::push_back<IncentiveAPYInfo>(&mut v0, v30);
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_incentive_apy_one(arg0: &0x2::clock::Clock, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: address) : IncentiveAPYInfo {
        let (_, _, v2, v3, v4, _, v6, v7, v8, _, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_info(arg1, arg4);
        let (_, v14, v15) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_funds_info(arg1, v2);
        let (v16, v17) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg2, v8);
        let v18 = v16;
        if (v7 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()) {
            v18 = v17;
        };
        0x1::vector::empty<0x1::ascii::String>();
        IncentiveAPYInfo{
            asset_id   : v8,
            apy        : 0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::ray_math::ray_div(0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::ray_math::ray_mul(0xf1aefc3be9355c217b2053f8b65ae01fa11b95bb73686f5fafa4fcb87902c50a::ray_math::ray_div(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::convert_amount(v6, 6, 9) as u256), v14), ((v4 - v3) as u256)), (31536000000 as u256)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg3, v18, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, v8))),
            coin_types : 0x1::vector::singleton<0x1::ascii::String>(0x1::type_name::into_string(v15)),
        }
    }

    public fun get_incentive_pools(arg0: &0x2::clock::Clock, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u8, arg5: address) : vector<IncentivePoolInfo> {
        let v0 = 0x1::vector::empty<IncentivePoolInfo>();
        let (_, _, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_from_asset_and_option(arg1, arg3, arg4);
        let v4 = v3;
        let v5 = 0x1::vector::length<address>(&v4);
        let (v6, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg2, arg3, arg5);
        let (v8, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg2, arg3);
        let v10 = v8;
        if (arg4 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()) {
            v10 = v9;
        };
        while (v5 > 0) {
            let v11 = *0x1::vector::borrow<address>(&v4, v5 - 1);
            let (v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, _, v23, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_info(arg1, v11);
            let (_, v26) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::calculate_one_from_pool(arg1, v11, 0x2::clock::timestamp_ms(arg0), v10, arg5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::calculate_user_effective_amount(v19, v6, v7, v21));
            let v27 = IncentivePoolInfo{
                pool_id      : v12,
                funds        : v14,
                phase        : v13,
                start_at     : v15,
                end_at       : v16,
                closed_at    : v17,
                total_supply : v18,
                asset_id     : v20,
                option       : v19,
                factor       : v21,
                distributed  : v23,
                available    : v26 - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_total_claimed_from_user(arg1, v11, arg5),
                total        : v26,
            };
            0x1::vector::push_back<IncentivePoolInfo>(&mut v0, v27);
            v5 = v5 - 1;
        };
        v0
    }

    public fun get_incentive_pools_group_by_phase(arg0: &0x2::clock::Clock, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u8, arg5: address) : vector<IncentivePoolInfoByPhase> {
        let v0 = 0x1::vector::empty<IncentivePoolInfoByPhase>();
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_objects(arg1);
        let v3 = 0x1::vector::length<address>(&v2);
        while (v3 > 0) {
            let v4 = *0x1::vector::borrow<address>(&v2, v3 - 1);
            let (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, _, v16, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_info(arg1, v4);
            if (arg4 != v12) {
                v3 = v3 - 1;
                continue
            };
            if (arg3 == 2 && v9 >= v1 || arg3 == 1 && (v8 >= v1 || v9 <= v1) || arg3 == 3 && v8 <= v1) {
                v3 = v3 - 1;
                continue
            };
            let (v18, v19) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg2, v13, arg5);
            let (v20, v21) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg2, v13);
            let v22 = v20;
            if (arg4 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()) {
                v22 = v21;
            };
            let (_, v24) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::calculate_one_from_pool(arg1, v4, v1, v22, arg5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::calculate_user_effective_amount(arg4, v18, v19, v14));
            let v25 = IncentivePoolInfo{
                pool_id      : v5,
                funds        : v7,
                phase        : v6,
                start_at     : v8,
                end_at       : v9,
                closed_at    : v10,
                total_supply : v11,
                asset_id     : v13,
                option       : arg4,
                factor       : v14,
                distributed  : v16,
                available    : v24 - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_total_claimed_from_user(arg1, v4, arg5),
                total        : v24,
            };
            let v26 = &mut v0;
            insert_pools(v26, &v25);
            v3 = v3 - 1;
        };
        v0
    }

    fun insert_pools(arg0: &mut vector<IncentivePoolInfoByPhase>, arg1: &IncentivePoolInfo) {
        let v0 = 0x1::vector::length<IncentivePoolInfoByPhase>(arg0);
        let v1 = false;
        while (v0 > 0) {
            let v2 = 0x1::vector::borrow_mut<IncentivePoolInfoByPhase>(arg0, v0 - 1);
            if (v2.phase != arg1.phase) {
                v0 = v0 - 1;
                continue
            };
            0x1::vector::push_back<IncentivePoolInfo>(&mut v2.pools, *arg1);
            v1 = true;
            v0 = v0 - 1;
        };
        if (v1) {
            return
        };
        let v3 = IncentivePoolInfoByPhase{
            phase : arg1.phase,
            pools : 0x1::vector::singleton<IncentivePoolInfo>(*arg1),
        };
        0x1::vector::push_back<IncentivePoolInfoByPhase>(arg0, v3);
    }

    // decompiled from Move bytecode v6
}

