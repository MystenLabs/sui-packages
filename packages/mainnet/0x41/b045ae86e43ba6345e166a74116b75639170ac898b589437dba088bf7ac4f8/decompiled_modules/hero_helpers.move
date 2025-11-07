module 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers {
    public(friend) fun add_land_influence(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_land(arg1, arg2, arg3));
        let v1 = 0x1::string::utf8(b"Influence");
        let v2 = if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &v1)) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1))
        } else {
            0
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_land_influence(arg0, arg1, arg3, v2 + arg4);
    }

    public(friend) fun calculate_boosted_influence_reward(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: u128, arg4: u128, arg5: u64) : (u64, u128, u64) {
        if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::has_item_staked(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag())) {
            let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag());
            let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0, 0));
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg0, arg1, arg2, v1);
            let v3 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v2);
            let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(v2);
            let v5 = if (0x1::option::is_some<u64>(&v4)) {
                *0x1::option::borrow<u64>(&v4)
            } else {
                100
            };
            if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::consume_durability(v2, 5)) {
                let v6 = get_banner_flag_boost_multiplier(&v3, v5);
                let v7 = arg3 * (v6 as u128) / (10000 as u128);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_item_cooldown_with_cap(arg0, arg1, arg2, v1, arg5 + 172800000);
                return (((v7 / arg4) as u64), v7 % arg4, v6)
            };
        };
        (((arg3 / arg4) as u64), arg3 % arg4, 10000)
    }

    public(friend) fun get_banner_flag_boost_multiplier(arg0: &0x1::string::String, arg1: u64) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 10250);
        0x1::vector::push_back<u64>(v1, 10500);
        0x1::vector::push_back<u64>(v1, 10750);
        0x1::vector::push_back<u64>(v1, 11000);
        0x1::vector::push_back<u64>(v1, 11250);
        0x1::vector::push_back<u64>(v1, 11500);
        0x1::vector::push_back<u64>(v1, 12000);
        0x1::vector::push_back<u64>(v1, 12500);
        0x1::vector::push_back<u64>(v1, 13000);
        0x1::vector::push_back<u64>(v1, 13750);
        0x1::vector::push_back<u64>(v1, 14250);
        0x1::vector::push_back<u64>(v1, 15000);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::calculate_tier_based_mul(arg0, arg1, v0)
    }

    public(friend) fun get_banner_flag_boost_readonly(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address) : u64 {
        if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::has_item_staked(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag())) {
            let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag());
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v1, 0)));
            if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_durability_value(v2) < 5) {
                return 10000
            };
            let v3 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v2);
            let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(v2);
            let v5 = if (0x1::option::is_some<u64>(&v4)) {
                *0x1::option::borrow<u64>(&v4)
            } else {
                100
            };
            get_banner_flag_boost_multiplier(&v3, v5)
        } else {
            10000
        }
    }

    public(friend) fun get_idol_boost_and_consume_durability(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: u64) : u128 {
        if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::has_item_staked(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma())) {
            let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma());
            let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0, 0));
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg0, arg1, arg2, v1);
            let v3 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v2);
            let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(v2);
            let v5 = if (0x1::option::is_some<u64>(&v4)) {
                *0x1::option::borrow<u64>(&v4)
            } else {
                100
            };
            if (!0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::consume_durability(v2, 5)) {
                return 10000
            };
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_item_cooldown_with_cap(arg0, arg1, arg2, v1, arg3 + get_urr_interval(arg2));
            let v6 = 0x1::vector::empty<u64>();
            let v7 = &mut v6;
            0x1::vector::push_back<u64>(v7, 15000);
            0x1::vector::push_back<u64>(v7, 20000);
            0x1::vector::push_back<u64>(v7, 25000);
            0x1::vector::push_back<u64>(v7, 30000);
            0x1::vector::push_back<u64>(v7, 35000);
            0x1::vector::push_back<u64>(v7, 40000);
            0x1::vector::push_back<u64>(v7, 50000);
            0x1::vector::push_back<u64>(v7, 60000);
            0x1::vector::push_back<u64>(v7, 70000);
            0x1::vector::push_back<u64>(v7, 85000);
            0x1::vector::push_back<u64>(v7, 95000);
            0x1::vector::push_back<u64>(v7, 110000);
            return (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::calculate_tier_based_mul(&v3, v5, v6) as u128)
        };
        10000
    }

    public(friend) fun get_runic_resonator_and_consume_durability(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: u64) : (bool, 0x1::string::String, u64, u64) {
        let (v0, v1, v2, v3) = if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::has_item_staked(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator())) {
            let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator());
            let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v4, 0));
            let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg0, arg1, arg2, v5);
            let v7 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v6);
            let v8 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(v6);
            let v9 = if (0x1::option::is_some<u64>(&v8)) {
                *0x1::option::borrow<u64>(&v8)
            } else {
                100
            };
            if (!0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::consume_durability(v6, 5)) {
                return (false, 0x1::string::utf8(b""), 0, 0)
            };
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_item_cooldown_with_cap(arg0, arg1, arg2, v5, arg3 + 86400000);
            let v10 = if (*0x1::string::as_bytes(&v7) == b"Common") {
                1
            } else if (*0x1::string::as_bytes(&v7) == b"Uncommon") {
                2
            } else if (*0x1::string::as_bytes(&v7) == b"Rare") {
                3
            } else if (*0x1::string::as_bytes(&v7) == b"Epic") {
                4
            } else if (*0x1::string::as_bytes(&v7) == b"Legendary") {
                6
            } else if (*0x1::string::as_bytes(&v7) == b"Mythic") {
                8
            } else {
                0
            };
            let v11 = if (v9 == 100) {
                v10 + 1
            } else {
                v10
            };
            (v7, v9, v11, true)
        } else {
            (0x1::string::utf8(b""), 0, 0, false)
        };
        (v3, v0, v1, v2)
    }

    public(friend) fun get_urr_interval(arg0: address) : u64 {
        if (is_test_user(arg0)) {
            86400000 / 24
        } else {
            86400000
        }
    }

    fun is_test_user(arg0: address) : bool {
        arg0 == @0x30fa04a11a6e96e34e5a9fb16d126ee6481b8bb65cfbf45c8959d9c56b38abd3 || arg0 == @0xbff7d619bc376d09745addd8d252461cddad51e73b5259100744117f4cba4b15
    }

    // decompiled from Move bytecode v6
}

