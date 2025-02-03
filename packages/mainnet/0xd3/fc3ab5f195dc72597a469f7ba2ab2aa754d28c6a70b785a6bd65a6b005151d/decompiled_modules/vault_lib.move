module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault_lib {
    public fun calculate_exit_amount(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::divide_u128((arg3 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::exp(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(arg0, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(((arg2 - arg1) as u128), 365), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1)))) as u64)
    }

    public fun calculate_pt_debt_amount(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg3 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::exp(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(arg0, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(((arg2 - arg1) as u128), 365), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1)))) as u64)
    }

    public fun filter_asset_ids(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: vector<u64>) : vector<u64> {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<u64>(&arg2), 401);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            if (arg0 == *0x1::vector::borrow<0x1::string::String>(&arg1, v1)) {
                0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(&arg2, v1));
            };
            v1 = v1 + 1;
        };
        let v2 = &mut v0;
        sort_u64(v2);
        v0
    }

    public fun get_amount_with_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        0x3::staking_pool::staked_sui_amount(arg1) + 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stake_data_provider::earnings_from_staked_sui(arg0, arg1, arg2)
    }

    public fun matching_asset_to_ratio(arg0: vector<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>, arg1: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64) : (0x1::option::Option<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>, 0x1::option::Option<u64>) {
        let v0 = 0x1::option::none<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>();
        let v1 = 0x1::option::none<u64>();
        let v2 = 1;
        while (v2 <= 20) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>(&arg0)) {
                let v4 = *0x1::vector::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>(&arg0, v3);
                if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::almost_equal(v4, arg1, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(v2, 20))) {
                    v0 = 0x1::option::some<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64>(v4);
                    v1 = 0x1::option::some<u64>(v3);
                    v2 = 21;
                    break
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun reduce_pool_list(arg0: vector<0x1::string::String>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0, v1);
            let (v3, _) = 0x1::vector::index_of<0x1::string::String>(&v0, &v2);
            if (v3 == false) {
                0x1::vector::push_back<0x1::string::String>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun sort_items(arg0: &mut vector<0x3::staking_pool::StakedSui>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0)) {
            let v1 = v0;
            while (v1 > 0) {
                v1 = v1 - 1;
                if (0x3::staking_pool::staked_sui_amount(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v1)) > 0x3::staking_pool::staked_sui_amount(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v0))) {
                    0x1::vector::swap<0x3::staking_pool::StakedSui>(arg0, v1, v1 + 1);
                } else {
                    break
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun sort_u64(arg0: &mut vector<u64>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = v0;
            while (v1 > 0) {
                v1 = v1 - 1;
                if (*0x1::vector::borrow<u64>(arg0, v1) > *0x1::vector::borrow<u64>(arg0, v0)) {
                    0x1::vector::swap<u64>(arg0, v1, v1 + 1);
                } else {
                    break
                };
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

