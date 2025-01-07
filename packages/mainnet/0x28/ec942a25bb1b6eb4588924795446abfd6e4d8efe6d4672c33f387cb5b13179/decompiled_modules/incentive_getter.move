module 0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::incentive_getter {
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
        available: u256,
        total: u256,
    }

    struct IncentiveAPYInfo has copy, drop {
        asset_id: u8,
        apy: u256,
        coin_types: vector<0x1::ascii::String>,
    }

    public fun get_incentive_apy(arg0: &0x2::clock::Clock, arg1: &0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::Incentive, arg2: &mut 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::Storage, arg3: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg4: u8) : vector<IncentiveAPYInfo> {
        let v0 = 0x1::vector::empty<IncentiveAPYInfo>();
        let v1 = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_reserves_count(arg2);
        while (v1 > 0) {
            let v2 = v1 - 1;
            let (v3, v4) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_total_supply(arg2, v2);
            let v5 = v3;
            if (arg4 == 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::option_borrow()) {
                v5 = v4;
            };
            let v6 = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_active_pools(arg1, v2, arg4, 0x2::clock::timestamp_ms(arg0));
            let v7 = 0x1::vector::length<address>(&v6);
            if (v7 == 0) {
                v1 = v1 - 1;
                continue
            };
            let v8 = 0;
            let v9 = 0x1::vector::empty<0x1::ascii::String>();
            while (v7 > 0) {
                let (_, _, v12, v13, v14, _, v16, _, _, _, _, _, _) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_pool_info(arg1, *0x1::vector::borrow<address>(&v6, v7 - 1));
                let (_, v24, v25) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_funds_info(arg1, v12);
                v8 = v8 + 0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::ray_math::ray_div(0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::ray_math::ray_mul(0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::ray_math::ray_div(0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::calculator::calculate_value(arg0, arg3, (0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::pool::convert_amount(v16, 6, 9) as u256), v24), ((v14 - v13) as u256)), (31536000000 as u256)), 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::calculator::calculate_value(arg0, arg3, v5, 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_oracle_id(arg2, v2)));
                let v26 = 0x1::type_name::into_string(v25);
                if (!0x1::vector::contains<0x1::ascii::String>(&v9, &v26)) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v9, 0x1::type_name::into_string(v25));
                };
                v7 = v7 - 1;
            };
            let v27 = IncentiveAPYInfo{
                asset_id   : v2,
                apy        : v8,
                coin_types : v9,
            };
            0x1::vector::push_back<IncentiveAPYInfo>(&mut v0, v27);
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_incentive_apy_one(arg0: &0x2::clock::Clock, arg1: &0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::Incentive, arg2: &mut 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::Storage, arg3: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg4: address) : IncentiveAPYInfo {
        let (_, _, v2, v3, v4, _, v6, v7, v8, _, _, _, _) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_pool_info(arg1, arg4);
        let (_, v14, v15) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_funds_info(arg1, v2);
        let (v16, v17) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_total_supply(arg2, v8);
        let v18 = v16;
        if (v7 == 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::option_borrow()) {
            v18 = v17;
        };
        0x1::vector::empty<0x1::ascii::String>();
        IncentiveAPYInfo{
            asset_id   : v8,
            apy        : 0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::ray_math::ray_div(0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::ray_math::ray_mul(0x28ec942a25bb1b6eb4588924795446abfd6e4d8efe6d4672c33f387cb5b13179::ray_math::ray_div(0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::calculator::calculate_value(arg0, arg3, (0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::pool::convert_amount(v6, 6, 9) as u256), v14), ((v4 - v3) as u256)), (31536000000 as u256)), 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::calculator::calculate_value(arg0, arg3, v18, 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_oracle_id(arg2, v8))),
            coin_types : 0x1::vector::singleton<0x1::ascii::String>(0x1::type_name::into_string(v15)),
        }
    }

    public fun get_incentive_pools(arg0: &0x2::clock::Clock, arg1: &0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::Incentive, arg2: &mut 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::Storage, arg3: u8, arg4: u8, arg5: address) : vector<IncentivePoolInfo> {
        let v0 = 0x1::vector::empty<IncentivePoolInfo>();
        let (_, _, v3) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_pool_from_asset_and_option(arg1, arg3, arg4);
        let v4 = v3;
        let v5 = 0x1::vector::length<address>(&v4);
        let (v6, v7) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_user_balance(arg2, arg3, arg5);
        let (v8, v9) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::storage::get_total_supply(arg2, arg3);
        let v10 = v8;
        if (arg4 == 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::option_borrow()) {
            v10 = v9;
        };
        while (v5 > 0) {
            let v11 = *0x1::vector::borrow<address>(&v4, v5 - 1);
            let (v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, _, _, _) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_pool_info(arg1, v11);
            let (_, v26) = 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::calculate_one_from_pool(arg1, v11, 0x2::clock::timestamp_ms(arg0), v10, arg5, 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::calculate_user_effective_amount(v19, v6, v7, v21));
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
                available    : v26 - 0xd93df89726d01938c95d94f252c43468c5b4fa161bd6b94de62b548e0daab6aa::incentive_v2::get_total_claimed_from_user(arg1, v11, arg5),
                total        : v26,
            };
            0x1::vector::push_back<IncentivePoolInfo>(&mut v0, v27);
            v5 = v5 - 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

