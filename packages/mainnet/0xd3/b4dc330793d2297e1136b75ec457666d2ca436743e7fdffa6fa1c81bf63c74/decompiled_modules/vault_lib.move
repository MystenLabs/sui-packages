module 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault_lib {
    public fun find_combination(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>, arg2: u64, arg3: u64) : vector<u64> {
        let (v0, v1) = normalize_into_ratio(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        let v6 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(1, 2);
        while (v5 <= 10000) {
            let (v7, v8) = matching_asset_to_ratio(&v3, v6);
            let v9 = v8;
            let v10 = v7;
            if (0x1::option::is_some<u64>(&v9)) {
                let v11 = *0x1::option::borrow<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(&v10);
                let v12 = *0x1::option::borrow<u64>(&v9);
                if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::greater_or_equal(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1), v11)) {
                    v6 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1), v11);
                    0x1::vector::swap_remove<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(&mut v3, v12);
                    0x1::vector::push_back<u64>(&mut v4, 0x1::vector::swap_remove<u64>(&mut v2, v12));
                    v5 = v5 + 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(10000, v11);
                    continue
                };
                0x1::vector::swap_remove<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(&mut v3, v12);
                0x1::vector::push_back<u64>(&mut v4, 0x1::vector::swap_remove<u64>(&mut v2, v12));
                v5 = 10001;
            } else {
                break
            };
        };
        v4
    }

    public fun find_one_with_minimal_excess(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = 0x1::option::none<u64>();
        while (v0 < 0x2::table_vec::length<0x3::staking_pool::StakedSui>(arg1)) {
            let v2 = 0x2::table_vec::borrow<0x3::staking_pool::StakedSui>(arg1, v0);
            if (arg3 > 0x3::staking_pool::stake_activation_epoch(v2)) {
                if (get_amount_with_rewards(arg0, v2, arg3) > arg2) {
                    v1 = 0x1::option::some<u64>(v0);
                    break
                };
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_amount_with_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        0x3::staking_pool::staked_sui_amount(arg1) + 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::stake_data_provider::earnings_from_staked_sui(arg0, arg1, arg2)
    }

    fun matching_asset_to_ratio(arg0: &vector<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : (0x1::option::Option<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>, 0x1::option::Option<u64>) {
        let v0 = 0x1::option::none<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>();
        let v1 = 0x1::option::none<u64>();
        let v2 = 1;
        while (v2 <= 20) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(arg0)) {
                let v4 = *0x1::vector::borrow<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(arg0, v3);
                if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::almost_equal(v4, arg1, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(v2, 20))) {
                    v0 = 0x1::option::some<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(v4);
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

    fun normalize_into_ratio(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>, arg2: u64, arg3: u64) : (vector<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x2::table_vec::length<0x3::staking_pool::StakedSui>(arg1)) {
            let v3 = 0x2::table_vec::borrow<0x3::staking_pool::StakedSui>(arg1, v2);
            if (arg3 > 0x3::staking_pool::stake_activation_epoch(v3)) {
                0x1::vector::push_back<0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64>(&mut v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((get_amount_with_rewards(arg0, v3, arg3) as u128), (arg2 as u128)));
                0x1::vector::push_back<u64>(&mut v1, v2);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun sort_items(arg0: &mut 0x2::table_vec::TableVec<0x3::staking_pool::StakedSui>) {
        let v0 = 1;
        while (v0 < 0x2::table_vec::length<0x3::staking_pool::StakedSui>(arg0)) {
            let v1 = v0;
            while (v1 > 0) {
                v1 = v1 - 1;
                if (0x3::staking_pool::staked_sui_amount(0x2::table_vec::borrow<0x3::staking_pool::StakedSui>(arg0, v1)) > 0x3::staking_pool::staked_sui_amount(0x2::table_vec::borrow<0x3::staking_pool::StakedSui>(arg0, v0))) {
                    0x2::table_vec::swap<0x3::staking_pool::StakedSui>(arg0, v1, v1 + 1);
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

