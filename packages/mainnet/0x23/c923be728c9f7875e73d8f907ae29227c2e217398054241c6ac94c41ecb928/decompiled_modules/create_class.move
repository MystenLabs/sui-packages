module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::create_class {
    public fun create_class_no_data(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg4: &0x2::clock::Clock) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg3);
        assert!(arg2 > 1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EInvalidMultiplier());
        assert!(!0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_in_staking_contract(arg3, arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetInStakingContract());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::insert_class(arg3, arg1, arg2, v0);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_class_created(arg1, arg2, false, v0);
    }

    // decompiled from Move bytecode v6
}

