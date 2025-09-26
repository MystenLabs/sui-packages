module 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers {
    public(friend) fun calculate_boosted_influence_reward(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: u64) : u64 {
        if (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::has_item_staked(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag())) {
            let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag());
            let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0, 0)));
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(v1);
            let v3 = if (0x1::option::is_some<u64>(&v2)) {
                *0x1::option::borrow<u64>(&v2)
            } else {
                100
            };
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::consume_durability(v1, 5);
            return arg3 * get_banner_flag_boost_multiplier(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v1), v3) / 10000
        };
        arg3
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

    // decompiled from Move bytecode v6
}

