module 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nestv2 {
    struct HarvestResultV2 has copy, drop {
        cycle_number: u64,
        success: bool,
        sht_earned: u64,
        died_this_cycle: bool,
    }

    struct HarvestCompletedV2 has copy, drop {
        nest_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        staked_duck_id: 0x2::object::ID,
        owner: address,
        cycles_harvested: u64,
        total_sht_earned: u64,
        deaths_occurred: u8,
        is_now_dead: bool,
        bones_count: u8,
    }

    struct DuckDiedV2 has copy, drop {
        staked_duck_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        cycle_number: u64,
        total_bones: u8,
        is_permanent: bool,
    }

    struct DuckRevivedV2 has copy, drop {
        staked_duck_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        deaths_revived: u8,
        sht_paid: u64,
        bones_remaining: u8,
    }

    struct DuckAutoRevivedV2 has copy, drop {
        staked_duck_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        bones_count: u8,
    }

    struct NestUpgradedV2 has copy, drop {
        nest_id: 0x2::object::ID,
        owner: address,
        old_level: u8,
        new_level: u8,
        sht_cost: u64,
    }

    struct DuckUnstakedV2 has copy, drop {
        nest_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        staked_duck_id: 0x2::object::ID,
        owner: address,
        slot_index: u8,
    }

    struct BatchHarvestCompletedV2 has copy, drop {
        owner: address,
        ducks_harvested: u64,
        total_cycles: u64,
        total_sht_earned: u64,
        total_deaths: u8,
    }

    struct CoinFlipResult has copy, drop {
        player: address,
        result: bool,
    }

    struct DeathState has copy, drop, store {
        bones_count: u8,
        is_dead: bool,
        pending_deaths: u8,
        frozen_until_time: u64,
        original_image_url: vector<u8>,
    }

    struct RevivalConfig has key {
        id: 0x2::object::UID,
        cost_1_bone: u64,
        cost_2_bones: u64,
        cost_3_bones: u64,
        freeze_1_bone: u64,
        freeze_2_bones: u64,
        freeze_3_bones: u64,
    }

    struct RevivalCostsUpdated has copy, drop {
        old_cost_1_bone: u64,
        old_cost_2_bones: u64,
        old_cost_3_bones: u64,
        new_cost_1_bone: u64,
        new_cost_2_bones: u64,
        new_cost_3_bones: u64,
        updated_by: address,
    }

    struct FreezeDurationsUpdated has copy, drop {
        old_freeze_1_bone: u64,
        old_freeze_2_bones: u64,
        old_freeze_3_bones: u64,
        new_freeze_1_bone: u64,
        new_freeze_2_bones: u64,
        new_freeze_3_bones: u64,
        updated_by: address,
    }

    entry fun admin_update_freeze_durations(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::NestAdminCap, arg1: &mut RevivalConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.freeze_1_bone = arg2;
        arg1.freeze_2_bones = arg3;
        arg1.freeze_3_bones = arg4;
        let v0 = FreezeDurationsUpdated{
            old_freeze_1_bone  : arg1.freeze_1_bone,
            old_freeze_2_bones : arg1.freeze_2_bones,
            old_freeze_3_bones : arg1.freeze_3_bones,
            new_freeze_1_bone  : arg2,
            new_freeze_2_bones : arg3,
            new_freeze_3_bones : arg4,
            updated_by         : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<FreezeDurationsUpdated>(v0);
    }

    entry fun admin_update_revival_costs(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::NestAdminCap, arg1: &mut RevivalConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.cost_1_bone = arg2;
        arg1.cost_2_bones = arg3;
        arg1.cost_3_bones = arg4;
        let v0 = RevivalCostsUpdated{
            old_cost_1_bone  : arg1.cost_1_bone,
            old_cost_2_bones : arg1.cost_2_bones,
            old_cost_3_bones : arg1.cost_3_bones,
            new_cost_1_bone  : arg2,
            new_cost_2_bones : arg3,
            new_cost_3_bones : arg4,
            updated_by       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RevivalCostsUpdated>(v0);
    }

    entry fun coin_flip(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = CoinFlipResult{
            player : 0x2::tx_context::sender(arg1),
            result : 0x2::random::generate_bool(&mut v0),
        };
        0x2::event::emit<CoinFlipResult>(v1);
    }

    entry fun create_revival_config(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::NestAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RevivalConfig{
            id             : 0x2::object::new(arg1),
            cost_1_bone    : 4000000000000,
            cost_2_bones   : 8000000000000,
            cost_3_bones   : 15000000000000,
            freeze_1_bone  : 86400000,
            freeze_2_bones : 172800000,
            freeze_3_bones : 345600000,
        };
        0x2::transfer::share_object<RevivalConfig>(v0);
    }

    fun get_base_luck(arg0: u8) : u8 {
        if (arg0 == 3) {
            85
        } else if (arg0 == 2) {
            60
        } else if (arg0 == 1) {
            50
        } else {
            40
        }
    }

    fun get_dead_image_for_rarity(arg0: u8) : vector<u8> {
        if (arg0 == 3) {
            b"https://gateway.lighthouse.storage/ipfs/bafybeibnghgxbaewd4tqxvjggtojl3q6eh7slre6c4ulqfcz7lk5g37lii/golden/g-r.png"
        } else if (arg0 == 2) {
            b"https://gateway.lighthouse.storage/ipfs/bafybeibnghgxbaewd4tqxvjggtojl3q6eh7slre6c4ulqfcz7lk5g37lii/king/k-r.png"
        } else if (arg0 == 1) {
            b"https://gateway.lighthouse.storage/ipfs/bafybeibnghgxbaewd4tqxvjggtojl3q6eh7slre6c4ulqfcz7lk5g37lii/queen/q-r.png"
        } else {
            b"https://gateway.lighthouse.storage/ipfs/bafybeibnghgxbaewd4tqxvjggtojl3q6eh7slre6c4ulqfcz7lk5g37lii/common/c-r.png"
        }
    }

    public fun get_freeze_duration(arg0: &RevivalConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.freeze_1_bone
        } else if (arg1 == 2) {
            arg0.freeze_2_bones
        } else {
            arg0.freeze_3_bones
        }
    }

    public fun get_freeze_durations(arg0: &RevivalConfig) : (u64, u64, u64) {
        (arg0.freeze_1_bone, arg0.freeze_2_bones, arg0.freeze_3_bones)
    }

    fun get_multiplier(arg0: u8) : u8 {
        if (arg0 == 3) {
            7
        } else if (arg0 == 2) {
            5
        } else if (arg0 == 1) {
            3
        } else {
            1
        }
    }

    fun get_nest_bonus(arg0: u8) : u8 {
        if (arg0 == 4) {
            15
        } else if (arg0 == 3) {
            10
        } else if (arg0 == 2) {
            5
        } else {
            0
        }
    }

    fun get_or_create_death_state_v2(arg0: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck) : DeathState {
        let v0 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_uid_mut(arg0);
        if (!0x2::dynamic_field::exists_<vector<u8>>(v0, b"death_state")) {
            let v1 = DeathState{
                bones_count        : 0,
                is_dead            : false,
                pending_deaths     : 0,
                frozen_until_time  : 0,
                original_image_url : 0x1::vector::empty<u8>(),
            };
            0x2::dynamic_field::add<vector<u8>, DeathState>(v0, b"death_state", v1);
        };
        *0x2::dynamic_field::borrow<vector<u8>, DeathState>(v0, b"death_state")
    }

    public fun get_revival_cost(arg0: &RevivalConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.cost_1_bone
        } else if (arg1 == 2) {
            arg0.cost_2_bones
        } else {
            arg0.cost_3_bones
        }
    }

    public fun get_revival_costs(arg0: &RevivalConfig) : (u64, u64, u64) {
        (arg0.cost_1_bone, arg0.cost_2_bones, arg0.cost_3_bones)
    }

    fun get_upgrade_cost(arg0: u8) : u64 {
        if (arg0 == 2) {
            4000000000000
        } else if (arg0 == 3) {
            6000000000000
        } else if (arg0 == 4) {
            10000000000000
        } else {
            0
        }
    }

    entry fun harvest_2_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg5: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg6: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg7: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg8: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg9: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::NestMintCapV2, arg10: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_harvest());
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::random::new_generator(arg11, arg13);
        let v2 = 0;
        let v3 = v2;
        let v4 = &mut v1;
        let (v5, v6, v7, v8) = process_single_harvest_v2(arg1, arg2, arg3, arg8, arg6, arg7, v4, arg12, v0, arg13);
        if (v7) {
            v3 = v2 + 1;
            let v9 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg2);
            let v10 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg2);
            let v11 = v8;
            let v12 = &mut v11;
            update_duck_death_image(arg6, arg7, arg2, v9, v12, v10, arg13);
            set_death_state_v2(arg2, v11);
        };
        let v13 = &mut v1;
        let (v14, v15, v16, v17) = process_single_harvest_v2(arg1, arg4, arg5, arg8, arg6, arg7, v13, arg12, v0, arg13);
        if (v16) {
            v3 = v3 + 1;
            let v18 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg4);
            let v19 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg4);
            let v20 = v17;
            let v21 = &mut v20;
            update_duck_death_image(arg6, arg7, arg4, v18, v21, v19, arg13);
            set_death_state_v2(arg4, v20);
        };
        let v22 = v5 + v14;
        let v23 = if (v6 > 0) {
            1
        } else {
            0
        };
        let v24 = if (v15 > 0) {
            1
        } else {
            0
        };
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::mint_for_nest_v2(arg9, arg10, v22, arg13), v0);
        };
        let v25 = BatchHarvestCompletedV2{
            owner            : v0,
            ducks_harvested  : v23 + v24,
            total_cycles     : v6 + v15,
            total_sht_earned : v22,
            total_deaths     : v3,
        };
        0x2::event::emit<BatchHarvestCompletedV2>(v25);
    }

    entry fun harvest_3_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg5: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg6: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg7: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg8: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg9: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg10: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg11: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::NestMintCapV2, arg12: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg13: &0x2::random::Random, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_harvest());
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0x2::random::new_generator(arg13, arg15);
        let v2 = 0;
        let v3 = v2;
        let v4 = &mut v1;
        let (v5, v6, v7, v8) = process_single_harvest_v2(arg1, arg2, arg3, arg10, arg8, arg9, v4, arg14, v0, arg15);
        if (v7) {
            v3 = v2 + 1;
            let v9 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg2);
            let v10 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg2);
            let v11 = v8;
            let v12 = &mut v11;
            update_duck_death_image(arg8, arg9, arg2, v9, v12, v10, arg15);
            set_death_state_v2(arg2, v11);
        };
        let v13 = &mut v1;
        let (v14, v15, v16, v17) = process_single_harvest_v2(arg1, arg4, arg5, arg10, arg8, arg9, v13, arg14, v0, arg15);
        if (v16) {
            v3 = v3 + 1;
            let v18 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg4);
            let v19 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg4);
            let v20 = v17;
            let v21 = &mut v20;
            update_duck_death_image(arg8, arg9, arg4, v18, v21, v19, arg15);
            set_death_state_v2(arg4, v20);
        };
        let v22 = &mut v1;
        let (v23, v24, v25, v26) = process_single_harvest_v2(arg1, arg6, arg7, arg10, arg8, arg9, v22, arg14, v0, arg15);
        if (v25) {
            v3 = v3 + 1;
            let v27 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg6);
            let v28 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg6);
            let v29 = v26;
            let v30 = &mut v29;
            update_duck_death_image(arg8, arg9, arg6, v27, v30, v28, arg15);
            set_death_state_v2(arg6, v29);
        };
        let v31 = v5 + v14 + v23;
        let v32 = if (v6 > 0) {
            1
        } else {
            0
        };
        let v33 = if (v15 > 0) {
            1
        } else {
            0
        };
        let v34 = if (v24 > 0) {
            1
        } else {
            0
        };
        if (v31 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::mint_for_nest_v2(arg11, arg12, v31, arg15), v0);
        };
        let v35 = BatchHarvestCompletedV2{
            owner            : v0,
            ducks_harvested  : v32 + v33 + v34,
            total_cycles     : v6 + v15 + v24,
            total_sht_earned : v31,
            total_deaths     : v3,
        };
        0x2::event::emit<BatchHarvestCompletedV2>(v35);
    }

    entry fun harvest_4_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg5: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg6: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg7: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg8: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg9: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg10: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg11: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg12: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg13: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::NestMintCapV2, arg14: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg15: &0x2::random::Random, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_harvest());
        let v0 = 0x2::tx_context::sender(arg17);
        let v1 = 0x2::random::new_generator(arg15, arg17);
        let v2 = 0;
        let v3 = v2;
        let v4 = &mut v1;
        let (v5, v6, v7, v8) = process_single_harvest_v2(arg1, arg2, arg3, arg12, arg10, arg11, v4, arg16, v0, arg17);
        if (v7) {
            v3 = v2 + 1;
            let v9 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg2);
            let v10 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg2);
            let v11 = v8;
            let v12 = &mut v11;
            update_duck_death_image(arg10, arg11, arg2, v9, v12, v10, arg17);
            set_death_state_v2(arg2, v11);
        };
        let v13 = &mut v1;
        let (v14, v15, v16, v17) = process_single_harvest_v2(arg1, arg4, arg5, arg12, arg10, arg11, v13, arg16, v0, arg17);
        if (v16) {
            v3 = v3 + 1;
            let v18 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg4);
            let v19 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg4);
            let v20 = v17;
            let v21 = &mut v20;
            update_duck_death_image(arg10, arg11, arg4, v18, v21, v19, arg17);
            set_death_state_v2(arg4, v20);
        };
        let v22 = &mut v1;
        let (v23, v24, v25, v26) = process_single_harvest_v2(arg1, arg6, arg7, arg12, arg10, arg11, v22, arg16, v0, arg17);
        if (v25) {
            v3 = v3 + 1;
            let v27 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg6);
            let v28 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg6);
            let v29 = v26;
            let v30 = &mut v29;
            update_duck_death_image(arg10, arg11, arg6, v27, v30, v28, arg17);
            set_death_state_v2(arg6, v29);
        };
        let v31 = &mut v1;
        let (v32, v33, v34, v35) = process_single_harvest_v2(arg1, arg8, arg9, arg12, arg10, arg11, v31, arg16, v0, arg17);
        if (v34) {
            v3 = v3 + 1;
            let v36 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg8);
            let v37 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg8);
            let v38 = v35;
            let v39 = &mut v38;
            update_duck_death_image(arg10, arg11, arg8, v36, v39, v37, arg17);
            set_death_state_v2(arg8, v38);
        };
        let v40 = v5 + v14 + v23 + v32;
        let v41 = if (v6 > 0) {
            1
        } else {
            0
        };
        let v42 = if (v15 > 0) {
            1
        } else {
            0
        };
        let v43 = if (v24 > 0) {
            1
        } else {
            0
        };
        let v44 = if (v33 > 0) {
            1
        } else {
            0
        };
        if (v40 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::mint_for_nest_v2(arg13, arg14, v40, arg17), v0);
        };
        let v45 = BatchHarvestCompletedV2{
            owner            : v0,
            ducks_harvested  : v41 + v42 + v43 + v44,
            total_cycles     : v6 + v15 + v24 + v33,
            total_sht_earned : v40,
            total_deaths     : v3,
        };
        0x2::event::emit<BatchHarvestCompletedV2>(v45);
    }

    entry fun harvest_5_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg5: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg6: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg7: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg8: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg9: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg10: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg11: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg12: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg13: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg14: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg15: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::NestMintCapV2, arg16: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg17: &0x2::random::Random, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_harvest());
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = 0x2::random::new_generator(arg17, arg19);
        let v2 = 0;
        let v3 = v2;
        let v4 = &mut v1;
        let (v5, v6, v7, v8) = process_single_harvest_v2(arg1, arg2, arg3, arg14, arg12, arg13, v4, arg18, v0, arg19);
        if (v7) {
            v3 = v2 + 1;
            let v9 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg2);
            let v10 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg2);
            let v11 = v8;
            let v12 = &mut v11;
            update_duck_death_image(arg12, arg13, arg2, v9, v12, v10, arg19);
            set_death_state_v2(arg2, v11);
        };
        let v13 = &mut v1;
        let (v14, v15, v16, v17) = process_single_harvest_v2(arg1, arg4, arg5, arg14, arg12, arg13, v13, arg18, v0, arg19);
        if (v16) {
            v3 = v3 + 1;
            let v18 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg4);
            let v19 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg4);
            let v20 = v17;
            let v21 = &mut v20;
            update_duck_death_image(arg12, arg13, arg4, v18, v21, v19, arg19);
            set_death_state_v2(arg4, v20);
        };
        let v22 = &mut v1;
        let (v23, v24, v25, v26) = process_single_harvest_v2(arg1, arg6, arg7, arg14, arg12, arg13, v22, arg18, v0, arg19);
        if (v25) {
            v3 = v3 + 1;
            let v27 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg6);
            let v28 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg6);
            let v29 = v26;
            let v30 = &mut v29;
            update_duck_death_image(arg12, arg13, arg6, v27, v30, v28, arg19);
            set_death_state_v2(arg6, v29);
        };
        let v31 = &mut v1;
        let (v32, v33, v34, v35) = process_single_harvest_v2(arg1, arg8, arg9, arg14, arg12, arg13, v31, arg18, v0, arg19);
        if (v34) {
            v3 = v3 + 1;
            let v36 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg8);
            let v37 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg8);
            let v38 = v35;
            let v39 = &mut v38;
            update_duck_death_image(arg12, arg13, arg8, v36, v39, v37, arg19);
            set_death_state_v2(arg8, v38);
        };
        let v40 = &mut v1;
        let (v41, v42, v43, v44) = process_single_harvest_v2(arg1, arg10, arg11, arg14, arg12, arg13, v40, arg18, v0, arg19);
        if (v43) {
            v3 = v3 + 1;
            let v45 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg10);
            let v46 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg10);
            let v47 = v44;
            let v48 = &mut v47;
            update_duck_death_image(arg12, arg13, arg10, v45, v48, v46, arg19);
            set_death_state_v2(arg10, v47);
        };
        let v49 = v5 + v14 + v23 + v32 + v41;
        let v50 = if (v6 > 0) {
            1
        } else {
            0
        };
        let v51 = if (v15 > 0) {
            1
        } else {
            0
        };
        let v52 = if (v24 > 0) {
            1
        } else {
            0
        };
        let v53 = if (v33 > 0) {
            1
        } else {
            0
        };
        let v54 = if (v42 > 0) {
            1
        } else {
            0
        };
        if (v49 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::mint_for_nest_v2(arg15, arg16, v49, arg19), v0);
        };
        let v55 = BatchHarvestCompletedV2{
            owner            : v0,
            ducks_harvested  : v50 + v51 + v52 + v53 + v54,
            total_cycles     : v6 + v15 + v24 + v33 + v42,
            total_sht_earned : v49,
            total_deaths     : v3,
        };
        0x2::event::emit<BatchHarvestCompletedV2>(v55);
    }

    entry fun harvest_duck_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg6: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg7: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::NestMintCapV2, arg8: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_harvest());
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_owner(arg3) == v0, 100);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_owner(arg2) == v0, 100);
        let v1 = 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck>(arg2);
        let v2 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_staked_duck_id(arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 101);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == v1, 102);
        let v3 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg2);
        let v4 = 0x2::clock::timestamp_ms(arg10);
        let v5 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_last_harvest(arg2);
        let v6 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg2);
        assert!(v4 >= v5 + 14400000, 103);
        let v7 = (v4 - v5) / 14400000;
        let v8 = if (v7 > 30) {
            30
        } else {
            v7
        };
        let v9 = get_base_luck(v6);
        let v10 = get_nest_bonus(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_level(arg3));
        let v11 = if (v9 + v10 > 100) {
            100
        } else {
            v9 + v10
        };
        let v12 = get_or_create_death_state_v2(arg2);
        if (v12.frozen_until_time > 0) {
            assert!(v4 >= v12.frozen_until_time, 105);
            v12.is_dead = false;
            v12.frozen_until_time = 0;
            v12.pending_deaths = 0;
            if (v12.bones_count >= 3) {
                v12.bones_count = 0;
            };
            0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_staked_duck_last_harvest(arg2, v12.frozen_until_time);
            let v13 = DuckAutoRevivedV2{
                staked_duck_id : v1,
                duck_id        : v3,
                owner          : v0,
                bones_count    : v12.bones_count,
            };
            0x2::event::emit<DuckAutoRevivedV2>(v13);
            restore_duck_image(arg4, arg5, arg2, v3, &v12, arg11);
            set_death_state_v2(arg2, v12);
        };
        assert!(!v12.is_dead, 104);
        let v14 = 0x2::random::new_generator(arg9, arg11);
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = 1;
        while (v18 <= v8) {
            let v19 = false;
            if (v12.bones_count < 3) {
                let v20 = if (v6 == 3) {
                    2
                } else {
                    3
                };
                if (0x2::random::generate_u64_in_range(&mut v14, 0, 99) < v20) {
                    v12.bones_count = v12.bones_count + 1;
                    v16 = v16 + 1;
                    v19 = true;
                    let v21 = DuckDiedV2{
                        staked_duck_id : v1,
                        duck_id        : v3,
                        owner          : v0,
                        cycle_number   : v18,
                        total_bones    : v12.bones_count,
                        is_permanent   : false,
                    };
                    0x2::event::emit<DuckDiedV2>(v21);
                };
            };
            if (!v19) {
                if (0x2::random::generate_u64_in_range(&mut v14, 0, 99) < (v11 as u64)) {
                    v15 = v15 + 200000000000 * (get_multiplier(v6) as u64);
                    v17 = v17 + 1;
                };
            };
            v18 = v18 + 1;
        };
        if (v16 > 0) {
            v12.is_dead = true;
            v12.pending_deaths = v16;
            v12.frozen_until_time = v4 + get_freeze_duration(arg1, v12.bones_count);
        };
        set_death_state_v2(arg2, v12);
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::mint_for_nest_v2(arg7, arg8, v15, arg11), v0);
        };
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::update_harvest_stats_v2(arg6, v0, v8, v17, v15, arg10);
        let v22 = if (v7 > 30) {
            v4
        } else {
            v5 + v7 * 14400000
        };
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_staked_duck_last_harvest(arg2, v22);
        if (v16 > 0) {
            let v23 = &mut v12;
            update_duck_death_image(arg4, arg5, arg2, v3, v23, v6, arg11);
            set_death_state_v2(arg2, v12);
        };
        let v24 = HarvestCompletedV2{
            nest_id          : 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest>(arg3),
            duck_id          : v3,
            staked_duck_id   : v1,
            owner            : v0,
            cycles_harvested : v8,
            total_sht_earned : v15,
            deaths_occurred  : v16,
            is_now_dead      : v16 > 0,
            bones_count      : v12.bones_count,
        };
        0x2::event::emit<HarvestCompletedV2>(v24);
    }

    fun process_single_harvest_v2(arg0: &RevivalConfig, arg1: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg2: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg3: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg6: &mut 0x2::random::RandomGenerator, arg7: &0x2::clock::Clock, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, DeathState) {
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_owner(arg2) == arg8, 100);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_owner(arg1) == arg8, 100);
        let v0 = 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck>(arg1);
        let v1 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_staked_duck_id(arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 101);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == v0, 102);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_last_harvest(arg1);
        let v4 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg1);
        let v5 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg1);
        let v6 = get_or_create_death_state_v2(arg1);
        if (v6.frozen_until_time > 0) {
            if (v2 >= v6.frozen_until_time) {
                let v7 = v6.frozen_until_time;
                v6.is_dead = false;
                v6.frozen_until_time = 0;
                v6.pending_deaths = 0;
                if (v6.bones_count >= 3) {
                    v6.bones_count = 0;
                };
                0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_staked_duck_last_harvest(arg1, v7);
                v3 = v7;
                let v8 = DuckAutoRevivedV2{
                    staked_duck_id : v0,
                    duck_id        : v5,
                    owner          : arg8,
                    bones_count    : v6.bones_count,
                };
                0x2::event::emit<DuckAutoRevivedV2>(v8);
                restore_duck_image(arg4, arg5, arg1, v5, &v6, arg9);
                set_death_state_v2(arg1, v6);
            } else {
                return (0, 0, false, v6)
            };
        };
        if (v6.is_dead) {
            return (0, 0, false, v6)
        };
        if (v2 < v3 + 14400000) {
            return (0, 0, false, v6)
        };
        let v9 = (v2 - v3) / 14400000;
        let v10 = if (v9 > 30) {
            30
        } else {
            v9
        };
        let v11 = get_base_luck(v4);
        let v12 = get_nest_bonus(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_level(arg2));
        let v13 = if (v11 + v12 > 100) {
            100
        } else {
            v11 + v12
        };
        let v14 = 0;
        let v15 = 0;
        let v16 = 1;
        let v17 = 0;
        while (v16 <= v10) {
            let v18 = false;
            if (v6.bones_count < 3) {
                let v19 = if (v4 == 3) {
                    2
                } else {
                    3
                };
                if (0x2::random::generate_u64_in_range(arg6, 0, 99) < v19) {
                    v6.bones_count = v6.bones_count + 1;
                    v17 = v17 + 1;
                    v18 = true;
                    let v20 = DuckDiedV2{
                        staked_duck_id : v0,
                        duck_id        : v5,
                        owner          : arg8,
                        cycle_number   : v16,
                        total_bones    : v6.bones_count,
                        is_permanent   : false,
                    };
                    0x2::event::emit<DuckDiedV2>(v20);
                };
            };
            if (!v18) {
                if (0x2::random::generate_u64_in_range(arg6, 0, 99) < (v13 as u64)) {
                    v14 = v14 + 200000000000 * (get_multiplier(v4) as u64);
                    v15 = v15 + 1;
                };
            };
            v16 = v16 + 1;
        };
        if (v17 > 0) {
            v6.is_dead = true;
            v6.pending_deaths = v17;
            v6.frozen_until_time = v2 + get_freeze_duration(arg0, v6.bones_count);
        };
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::update_harvest_stats_v2(arg3, arg8, v10, v15, v14, arg7);
        let v21 = if (v9 > 30) {
            v2
        } else {
            v3 + v9 * 14400000
        };
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_staked_duck_last_harvest(arg1, v21);
        set_death_state_v2(arg1, v6);
        (v14, v10, v17 > 0, v6)
    }

    fun restore_duck_image(arg0: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: 0x2::object::ID, arg4: &DeathState, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staking_kiosk_mut(arg0);
        0x2::kiosk::list<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v0, v1, arg3, 0);
        let (v2, v3) = 0x2::kiosk::purchase<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v0, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v4 = v3;
        let v5 = v2;
        if (0x1::vector::length<u8>(&arg4.original_image_url) > 0) {
            0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::update_image_url(&mut v5, 0x1::string::utf8(arg4.original_image_url));
        };
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::update_death_attributes(&mut v5, false, arg4.bones_count);
        0x2::kiosk::lock<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v0, v1, arg1, v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(&mut v4, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg1, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg1, v4);
    }

    entry fun revive_duck_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg6: &mut 0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>, arg7: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_revive());
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_owner(arg3) == v0, 100);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_owner(arg2) == v0, 100);
        let v1 = 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck>(arg2);
        let v2 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_staked_duck_id(arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 101);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == v1, 102);
        let v3 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(arg2);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(arg2);
        let v4 = get_or_create_death_state_v2(arg2);
        assert!(v4.is_dead, 107);
        let v5 = get_revival_cost(arg1, v4.bones_count);
        assert!(0x2::coin::value<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>(arg6) >= v5, 106);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::burn(arg7, 0x2::coin::split<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>(arg6, v5, arg9));
        v4.is_dead = false;
        v4.pending_deaths = 0;
        v4.frozen_until_time = 0;
        if (v4.bones_count >= 3) {
            v4.bones_count = 0;
        };
        restore_duck_image(arg4, arg5, arg2, v3, &v4, arg9);
        set_death_state_v2(arg2, v4);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_staked_duck_last_harvest(arg2, 0x2::clock::timestamp_ms(arg8));
        let v6 = DuckRevivedV2{
            staked_duck_id  : v1,
            duck_id         : v3,
            owner           : v0,
            deaths_revived  : v4.pending_deaths,
            sht_paid        : v5,
            bones_remaining : v4.bones_count,
        };
        0x2::event::emit<DuckRevivedV2>(v6);
    }

    fun set_death_state_v2(arg0: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg1: DeathState) {
        *0x2::dynamic_field::borrow_mut<vector<u8>, DeathState>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_uid_mut(arg0), b"death_state") = arg1;
    }

    entry fun unstake_duck_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &RevivalConfig, arg2: 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg7: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg8: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::HarvestStats, arg9: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::NestMintCapV2, arg10: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_stake());
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::clock::timestamp_ms(arg12);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_owner(arg3) == v0, 100);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_owner(&arg2) == v0, 100);
        let v2 = 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck>(&arg2);
        let v3 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_staked_duck_id(arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v3), 101);
        let v4 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_staked_duck_id(arg3);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v4) == v2, 102);
        let v5 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_duck_id(&arg2);
        let v6 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_rarity(&arg2);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_multiplier(&arg2);
        let v7 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staked_duck_last_harvest(&arg2);
        let v8 = &mut arg2;
        let v9 = get_or_create_death_state_v2(v8);
        if (v9.frozen_until_time > 0) {
            assert!(v1 >= v9.frozen_until_time, 105);
            let v10 = v9.frozen_until_time;
            v9.is_dead = false;
            v9.frozen_until_time = 0;
            v9.pending_deaths = 0;
            if (v9.bones_count >= 3) {
                v9.bones_count = 0;
            };
            0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_staked_duck_last_harvest(&mut arg2, v10);
            v7 = v10;
            let v11 = DuckAutoRevivedV2{
                staked_duck_id : v2,
                duck_id        : v5,
                owner          : v0,
                bones_count    : v9.bones_count,
            };
            0x2::event::emit<DuckAutoRevivedV2>(v11);
            let v12 = &mut arg2;
            restore_duck_image(arg6, arg7, v12, v5, &v9, arg13);
            let v13 = &mut arg2;
            set_death_state_v2(v13, v9);
        };
        assert!(!v9.is_dead, 104);
        let v14 = (v1 - v7) / 14400000;
        if (v14 > 0) {
            let v15 = if (v14 > 30) {
                30
            } else {
                v14
            };
            let v16 = get_base_luck(v6);
            let v17 = get_nest_bonus(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_level(arg3));
            let v18 = if (v16 + v17 > 100) {
                100
            } else {
                v16 + v17
            };
            let v19 = 0x2::random::new_generator(arg11, arg13);
            let v20 = 0;
            let v21 = 0;
            let v22 = 1;
            let v23 = 0;
            while (v22 <= v15) {
                let v24 = false;
                if (v9.bones_count < 3) {
                    let v25 = if (v6 == 3) {
                        2
                    } else {
                        3
                    };
                    if (0x2::random::generate_u64_in_range(&mut v19, 0, 99) < v25) {
                        v9.bones_count = v9.bones_count + 1;
                        v23 = v23 + 1;
                        v24 = true;
                        let v26 = DuckDiedV2{
                            staked_duck_id : v2,
                            duck_id        : v5,
                            owner          : v0,
                            cycle_number   : v22,
                            total_bones    : v9.bones_count,
                            is_permanent   : false,
                        };
                        0x2::event::emit<DuckDiedV2>(v26);
                    };
                };
                if (!v24) {
                    if (0x2::random::generate_u64_in_range(&mut v19, 0, 99) < (v18 as u64)) {
                        v20 = v20 + 200000000000 * (get_multiplier(v6) as u64);
                        v21 = v21 + 1;
                    };
                };
                v22 = v22 + 1;
            };
            if (v23 > 0) {
                v9.is_dead = true;
                v9.pending_deaths = v23;
                v9.frozen_until_time = v1 + get_freeze_duration(arg1, v9.bones_count);
            };
            let v27 = &mut arg2;
            set_death_state_v2(v27, v9);
            if (v20 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>>(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::mint_for_nest_v2(arg9, arg10, v20, arg13), v0);
            };
            0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::update_harvest_stats_v2(arg8, v0, v15, v21, v20, arg12);
            if (v23 > 0) {
                let v28 = &mut arg2;
                let v29 = &mut v9;
                update_duck_death_image(arg6, arg7, v28, v5, v29, v6, arg13);
                let v30 = &mut arg2;
                set_death_state_v2(v30, v9);
                let v31 = HarvestCompletedV2{
                    nest_id          : 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest>(arg3),
                    duck_id          : v5,
                    staked_duck_id   : v2,
                    owner            : v0,
                    cycles_harvested : v15,
                    total_sht_earned : v20,
                    deaths_occurred  : v23,
                    is_now_dead      : true,
                    bones_count      : v9.bones_count,
                };
                0x2::event::emit<HarvestCompletedV2>(v31);
                0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::return_staked_duck(arg2, v0);
                return
            };
        };
        let (v32, v33) = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staking_kiosk_mut(arg6);
        0x2::kiosk::list<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v32, v33, v5, 0);
        let (v34, v35) = 0x2::kiosk::purchase<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v32, v5, 0x2::coin::zero<0x2::sui::SUI>(arg13));
        let v36 = v35;
        let v37 = v34;
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::mark_as_unstaked(&mut v37);
        0x2::kiosk::lock<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg4, arg5, arg7, v37);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(&mut v36, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg7, &mut v36, 0x2::coin::zero<0x2::sui::SUI>(arg13));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg7, v36);
        let (v41, v42, v43) = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::delete_staked_duck_v2(arg2);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::clear_nest_staked_duck(arg3);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::decrement_active_ducks(arg8);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::update_user_stake_stats_v2(arg8, v0, false, arg12);
        let v44 = DuckUnstakedV2{
            nest_id        : v43,
            duck_id        : v42,
            staked_duck_id : v41,
            owner          : v0,
            slot_index     : 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_index(arg3),
        };
        0x2::event::emit<DuckUnstakedV2>(v44);
    }

    fun update_duck_death_image(arg0: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakingKiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>, arg2: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::StakedDuck, arg3: 0x2::object::ID, arg4: &mut DeathState, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_staking_kiosk_mut(arg0);
        0x2::kiosk::list<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v0, v1, arg3, 0);
        let (v2, v3) = 0x2::kiosk::purchase<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v0, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v4 = v3;
        let v5 = v2;
        if (0x1::vector::length<u8>(&arg4.original_image_url) == 0) {
            let v6 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::get_image_url(&v5);
            arg4.original_image_url = *0x1::string::as_bytes(&v6);
        };
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::update_image_url(&mut v5, 0x1::string::utf8(get_dead_image_for_rarity(arg5)));
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::update_death_attributes(&mut v5, true, arg4.bones_count);
        0x2::kiosk::lock<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(v0, v1, arg1, v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(&mut v4, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg1, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::duck_nft::DuckNFT>(arg1, v4);
    }

    entry fun upgrade_nest_v2(arg0: &0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::GlobalConfig, arg1: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest, arg2: &mut 0x2::coin::Coin<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>, arg3: &mut 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SharedTreasury, arg4: &mut 0x2::tx_context::TxContext) {
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::assert_version_and_feature(arg0, 11, 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::config::feature_upgrade_nest());
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_owner(arg1) == v0, 100);
        let v1 = 0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::get_nest_level(arg1);
        assert!(v1 < 4, 109);
        let v2 = v1 + 1;
        let v3 = get_upgrade_cost(v2);
        assert!(0x2::coin::value<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>(arg2) >= v3, 108);
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::burn(arg3, 0x2::coin::split<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::shttoken::SHTTOKEN>(arg2, v3, arg4));
        0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::set_nest_level(arg1, v2);
        let v4 = NestUpgradedV2{
            nest_id   : 0x2::object::id<0xeb318d9d390434d5a422fc0e9e3c5eed83bb43c79303562f2739ed029ce94591::nest::Nest>(arg1),
            owner     : v0,
            old_level : v1,
            new_level : v2,
            sht_cost  : v3,
        };
        0x2::event::emit<NestUpgradedV2>(v4);
    }

    // decompiled from Move bytecode v6
}

