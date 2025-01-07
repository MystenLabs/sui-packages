module 0xb6b6920e6d9714490c097ee2afc202d33ac9a91dd480f30e2097f141b227f747::hive_chronicles {
    struct HiveChroniclesVault has key {
        id: 0x2::object::UID,
        hive_entry_cap: 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::HiveEntryCap,
        hive_chronicle_dof_cap: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability,
        airdrop_vault_dof_manager_cap: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::ManagerAppAccessCapability,
        lockdrop_vault_dof_manager_cap: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::ManagerAppAccessCapability,
        infusion_vault_dof_manager_cap: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::ManagerAppAccessCapability,
        system_infusion_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, InfusionBuzz>,
        hive_chronicle_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes_list: vector<0x1::string::String>,
        total_bees_available: 0x2::balance::Balance<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>,
        bee_farm_info: BeeFarmInfo,
        bees_farming_snampshots: 0x2::linked_table::LinkedTable<u64, BeesFarmingSnapshot>,
    }

    struct BeeFarmInfo has copy, store {
        active_epoch: u64,
        bees_for_epoch: u64,
        likes_during_epoch: u64,
        dialogues_during_epoch: u64,
    }

    struct BeesFarmingSnapshot has copy, store {
        epoch: u64,
        bees_distributed: u64,
        likes_farmed: u64,
        dialogues_farmed: u64,
        bees_per_like: u256,
        bees_per_dialogue: u256,
        bees_burnt: u64,
    }

    struct InfusionBuzz has copy, drop, store {
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct ChronicleBuzz has copy, drop, store {
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct HiveChronicles has store, key {
        id: 0x2::object::UID,
        active_epoch: u64,
        engagement_metrics: EngagementInfo,
        noise_buzzes: 0x2::linked_table::LinkedTable<u64, UserNoiseBuzz>,
        last_noise_epoch: u64,
        noise_count: u64,
        chronicle_buzzes: 0x2::linked_table::LinkedTable<u64, UserChronicleBuzz>,
        last_chronicle_epoch: u64,
        chronicle_count: u64,
        buzz_chains: 0x2::linked_table::LinkedTable<u64, vector<BuzzChain>>,
        last_buzz_epoch: u64,
        buzz_count: u64,
        subscribers_only: bool,
        infusion_buzzes: 0x2::linked_table::LinkedTable<u64, UserInfusionBuzz>,
        infusion_count: u64,
    }

    struct EngagementInfo has store {
        likes_made: u64,
        likes_earned: u64,
        dialogues_made: u64,
        dialogues_earned: u64,
        bees_farmed: 0x2::linked_table::LinkedTable<u64, u64>,
        bees_to_claim: u64,
    }

    struct UserInfusionBuzz has store {
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct UserNoiseBuzz has store {
        timestamp: u64,
        epoch: u64,
        noise: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, Dialogue>,
    }

    struct UserChronicleBuzz has store {
        timestamp: u64,
        asset_id: u64,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, Dialogue>,
    }

    struct BuzzChain has store {
        timestamp: u64,
        narrative: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        appreciations: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, Dialogue>,
    }

    struct Dialogue has store {
        dialogue: 0x1::string::String,
        upvotes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct BeeFarmDistributionEpochElapsed has copy, drop {
        epoch_over: u64,
        likes_farmed: u64,
        dialogues_farmed: u64,
        bees_distributed: u64,
        bees_per_like: u256,
        bees_per_dialogue: u256,
        bees_burnt: u64,
        next_epoch_bees_for_farming: u64,
    }

    struct BeesFarmedByProfileComputed has copy, drop {
        username: 0x1::string::String,
        profile_addr: address,
        for_epoch: u64,
        likes_made: u64,
        likes_earned: u64,
        dialogues_made: u64,
        dialogues_earned: u64,
        bees_from_likes: u64,
        bees_from_dialogues: u64,
    }

    struct ClaimBeesFromFarming has copy, drop {
        bees_farmed: u64,
        username: 0x1::string::String,
        profile_addr: address,
    }

    struct NewInfusionBuzz has copy, drop {
        username: 0x1::string::String,
        infusion_count: u64,
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct NewNoiseBuzz has copy, drop {
        username: 0x1::string::String,
        noise_index: u64,
        timestamp: u64,
        epoch: u64,
        noise: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct NewBuzzChainEntry has copy, drop {
        timestamp: u64,
        epoch: u64,
        entry_index: u64,
        username: 0x1::string::String,
        content: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct NewChronicleBuzz has copy, drop {
        username: 0x1::string::String,
        log_index: u64,
        timestamp: u64,
        asset_id: u64,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct BuzzLiked has copy, drop {
        liked_by_username: 0x1::string::String,
        poster_username: 0x1::string::String,
        liked_by_profile_addr: address,
        poster_profile_addr: address,
        buzz_type: u8,
        buzz_index: u64,
        thread_index: u64,
    }

    struct DialogueAdded has copy, drop {
        by_username: 0x1::string::String,
        by_profile_addr: address,
        poster_username: 0x1::string::String,
        poster_profile_addr: address,
        buzz_type: u8,
        buzz_index: u64,
        thread_index: u64,
        dialogue: 0x1::string::String,
        to_remove: bool,
    }

    struct DialogueUpvoted has copy, drop {
        upvoted_by_username: 0x1::string::String,
        upvoted_by_profile_addr: address,
        poster_username: 0x1::string::String,
        poster_profile_addr: address,
        dialogue_by_username: 0x1::string::String,
        dialogue_by_profile_addr: address,
        buzz_type: u8,
        buzz_index: u64,
        thread_index: u64,
    }

    public entry fun add_hive_for_airdrop<T0>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg5: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x70dd53a1a08f011bd9ae8192ce0f66704d57ead46a64ab7efc1abc6b565fb8a::airdrop::add_hive_for_airdrop(arg2, &arg1.airdrop_vault_dof_manager_cap, arg3, arg5, arg6, arg7);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"ADD_HIVE_FOR_AIRDROP"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg7);
    }

    public entry fun claim_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: u64, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x70dd53a1a08f011bd9ae8192ce0f66704d57ead46a64ab7efc1abc6b565fb8a::airdrop::claim_hive_airdrop(&arg0.airdrop_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v1, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"Welcome to DegenHive, @");
        0x1::string::append(&mut v4, v1);
        0x1::string::append(&mut v4, 0x1::string::utf8(b"! You've claimed "));
        0x1::string::append(&mut v4, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" HIVE Tokens, Currently safeguarded in HiveAirdropHolder dynamic object stored with your HiveProfile!"));
        let v5 = 0x1::string::utf8(b"CLAIM_AIRDROP");
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v5);
        0x1::string::append(&mut v4, v6.buzz);
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v1, v7, v5, v4, v6.gen_ai);
    }

    public entry fun initialize_airdrop_vault<T0>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg5: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x70dd53a1a08f011bd9ae8192ce0f66704d57ead46a64ab7efc1abc6b565fb8a::airdrop::initialize_airdrop_vault(arg2, &arg1.airdrop_vault_dof_manager_cap, arg5, arg3, arg6, arg7, arg8, arg9);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_AIRDROP_VAULT"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg9);
    }

    public entry fun transfer_unclaimed_hive<T0>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg5: &mut 0x2::tx_context::TxContext) {
        0x70dd53a1a08f011bd9ae8192ce0f66704d57ead46a64ab7efc1abc6b565fb8a::airdrop::transfer_unclaimed_hive(&arg1.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_AIRDROP_COMPLETE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg5);
    }

    public entry fun update_airdrop_vault<T0>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x70dd53a1a08f011bd9ae8192ce0f66704d57ead46a64ab7efc1abc6b565fb8a::airdrop::update_airdrop_vault(&arg1.airdrop_vault_dof_manager_cap, arg3, arg5, arg6, arg7);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_AIRDROP_VAULT_UPDATED"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg7);
    }

    public entry fun withdraw_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v4 = 0x1::string::utf8(b"You've withdrawn ");
        0x1::string::append(&mut v4, make_num_with_decimals((0x70dd53a1a08f011bd9ae8192ce0f66704d57ead46a64ab7efc1abc6b565fb8a::airdrop::withdraw_hive_airdrop(&arg0.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5) as u128), 6));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" HIVE GEMS, @"));
        0x1::string::append(&mut v4, v1);
        let v5 = 0x1::string::utf8(b"WITHDRAW_AIRDROP");
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v5);
        0x1::string::append(&mut v4, v6.buzz);
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg4, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v1, v7, v5, v4, v6.gen_ai);
    }

    public entry fun add_incentives_for_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::LockdropForPool<T1, T2>, arg3: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg4: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg5: u64, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::add_incentives_for_cetus_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for Cetus DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg3: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg4: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg5: u64, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::add_incentives_for_flowx_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for FlowX DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg3: &0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaAttackConfig, arg4: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg5: u64, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::add_incentives_for_kriya_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for Kriya DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_lsd_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::LsdLockdropVault, arg3: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg4: u64, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" additional HIVE tokens added as rewards for SUI-hiveSUI Lockdrop Pool!"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72205355492d68697665535549204c6f636b64726f703a20"));
        0x1::string::append(&mut v0, make_num_with_decimals((0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::add_incentives_for_lsd_lockdrop(arg0, arg2, arg3, arg4, arg6) as u128), 6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg5, v0, 0x1::option::none<0x1::string::String>(), arg6);
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2, T3>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T1, T2, T3>, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::add_liquidity_to_degenhive<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg6);
        let v8 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"LIQUIDITY_ADDED_TO_DEGENHIVE"));
        let v9 = v0;
        0x1::string::append(&mut v9, v8.buzz);
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(b"Total DegenHive's LP krafted: "));
        0x1::string::append(&mut v8.buzz, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(b" LP"));
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(x"0a546f74616c20"));
        0x1::string::append(&mut v8.buzz, v2);
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(b" added to the pool: "));
        0x1::string::append(&mut v8.buzz, make_num_with_decimals((v3 as u128), (v4 as u64)));
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(b" "));
        0x1::string::append(&mut v8.buzz, v2);
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(x"0a546f74616c20"));
        0x1::string::append(&mut v8.buzz, v5);
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(b" added to the pool: "));
        0x1::string::append(&mut v8.buzz, make_num_with_decimals((v6 as u128), (v7 as u64)));
        0x1::string::append(&mut v8.buzz, 0x1::string::utf8(b" "));
        0x1::string::append(&mut v8.buzz, v5);
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg5, v8.buzz, v8.gen_ai, arg6);
    }

    public entry fun claim_liquidity_from_cetus<T0, T1, T2, T3>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::LockdropForPool<T1, T2>, arg5: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10, v11, v12, v13, v14) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::claim_liquidity_from_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        internal_kraft_cetus_claim_liquidity_stream<T0>(arg2, arg6, arg1, v0, v1, v2, v3, v4, v5, v6, v8, v9, v10, v11, v12, v13, v14, arg7);
    }

    public entry fun claim_liquidity_from_rev_cetus<T0, T1, T2, T3>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::LockdropForPool<T2, T1>, arg5: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10, v11, v12, v13, v14) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::claim_liquidity_from_rev_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        internal_kraft_cetus_claim_liquidity_stream<T0>(arg2, arg6, arg1, v0, v1, v2, v3, v4, v5, v6, v8, v9, v10, v11, v12, v13, v14, arg7);
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2, T3>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::extract_liquidity_from_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let v11 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"FLOWX_LIQUIDITY_CLAIMED"));
        let v12 = v1;
        0x1::string::append(&mut v12, v11.buzz);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v12, 0x1::string::utf8(b"Total FlowX LP tokens deposited for the lockdrop: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v12, 0x1::string::utf8(x"204c500a0a"));
        0x1::string::append(&mut v12, v2);
        0x1::string::append(&mut v12, 0x1::string::utf8(b" Liquidity withdrawn from FlowX pool: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v12, v2);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v12, v3);
        0x1::string::append(&mut v12, 0x1::string::utf8(b" Liquidity withdrawn from FlowX pool: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v12, v3);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a0a546f74616c204849564520696e63656e746976657320666f7220466c6f7758204c6f636b64726f703a20"));
        0x1::string::append(&mut v12, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v12, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v12, v11.gen_ai, arg8);
    }

    public entry fun extract_liquidity_from_kriya<T0, T1, T2, T3>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaAttackConfig, arg4: &mut 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T2>, arg6: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::extract_liquidity_from_kriya<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let v11 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"KRIYA_LIQUIDITY_CLAIMED"));
        let v12 = v1;
        0x1::string::append(&mut v12, v11.buzz);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v12, 0x1::string::utf8(b"Total kriya LP tokens deposited for the lockdrop: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v12, 0x1::string::utf8(x"204c500a0a"));
        0x1::string::append(&mut v12, v2);
        0x1::string::append(&mut v12, 0x1::string::utf8(b" Liquidity withdrawn from Kriya pool: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v12, v2);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v12, v3);
        0x1::string::append(&mut v12, 0x1::string::utf8(b" Liquidity withdrawn from Kriya pool: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v12, v3);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a0a546f74616c204849564520696e63656e746976657320666f72204b72697961204c6f636b64726f703a20"));
        0x1::string::append(&mut v12, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v12, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v12, v11.gen_ai, arg8);
    }

    public entry fun extract_liquidity_from_rev_flowx<T0, T1, T2, T3>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T2, T1>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::extract_liquidity_from_rev_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let v11 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"FLOWX_LIQUIDITY_CLAIMED"));
        let v12 = v1;
        0x1::string::append(&mut v12, v11.buzz);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v12, 0x1::string::utf8(b"Total FlowX LP tokens deposited for the lockdrop: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v12, 0x1::string::utf8(x"204c500a0a"));
        0x1::string::append(&mut v12, v2);
        0x1::string::append(&mut v12, 0x1::string::utf8(b" Liquidity withdrawn from FlowX pool: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v12, v2);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v12, v3);
        0x1::string::append(&mut v12, 0x1::string::utf8(b" Liquidity withdrawn from FlowX pool: "));
        0x1::string::append(&mut v12, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v12, v3);
        0x1::string::append(&mut v12, 0x1::string::utf8(x"0a0a546f74616c204849564520696e63656e746976657320666f7220466c6f7758204c6f636b64726f703a20"));
        0x1::string::append(&mut v12, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v12, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v12, v11.gen_ai, arg8);
    }

    public entry fun infuse_sui_hsui_pool<T0>(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropVault, arg4: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<0x2::sui::SUI, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg8: &mut 0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::infuse_sui_hsui_pool(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"SUI_HIVESUI_INFUSED"));
        0x1::string::append(&mut v4.buzz, make_num_with_decimals((v1 as u128), (9 as u64)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" SUI + "));
        0x1::string::append(&mut v4.buzz, make_num_with_decimals((v0 as u128), (9 as u64)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" HSUI"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a0a20546f74616c205355492d68697665535549204c5020746f6b656e73206b7261667465643a20"));
        0x1::string::append(&mut v4.buzz, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" LP tokens"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a0a546f74616c204849564520696e63656e746976657320666f72205355492d68697665535549204c6f636b64726f703a20"));
        0x1::string::append(&mut v4.buzz, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v4.buzz, v4.gen_ai, arg9);
    }

    public entry fun initialize_attack_on_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg3: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg9: u64, arg10: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        let v1 = 0x1::string::utf8(b"Vampire Attack on Cetus DEX's ");
        0x1::string::append(&mut v1, arg6);
        0x1::string::append(&mut v1, v0.buzz);
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204365747573204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v1, 0x2::address::to_string(0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_attack_on_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v1, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE "));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v1, v0.gen_ai, arg11);
    }

    public entry fun initialize_attack_on_flowx_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg3: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: u8, arg7: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg8: u64, arg9: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg10) {
            0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_attack_on_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
        } else {
            0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_attack_on_rev_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
        };
        let v1 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"FLOWX_ATTACK_INITIALIZED_FOR_POOL"));
        let v2 = 0x1::string::utf8(b"Vampire Attack on FlowX DEX's ");
        0x1::string::append(&mut v2, arg5);
        0x1::string::append(&mut v2, v1.buzz);
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a20466c6f7758204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(v0));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((arg8 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE "));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg9, v2, v1.gen_ai, arg11);
    }

    public entry fun initialize_attack_on_kriya_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg3: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T1, T2>, arg5: &mut 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg9: u64, arg10: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"KRIYA_ATTACK_INITIALIZED_FOR_POOL"));
        let v1 = 0x1::string::utf8(b"Vampire Attack on Kriya DEX's ");
        0x1::string::append(&mut v1, arg6);
        0x1::string::append(&mut v1, v0.buzz);
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204b72697961204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v1, 0x2::address::to_string(0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_attack_on_kriya_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v1, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE "));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v1, v0.gen_ai, arg11);
    }

    public entry fun initialize_lockdrop_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg3: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfileMappingStore, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: u8, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_FOR_POOL"));
        0x1::string::append(&mut arg11, v0.buzz);
        0x1::string::append(&mut arg11, 0x1::string::utf8(x"0a4c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut arg11, 0x2::address::to_string(0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_lockdrop_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, arg11, v0.gen_ai, arg18);
    }

    public entry fun initialize_lockdrops<T0>(arg0: &HiveChroniclesVault, arg1: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg3: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfileMappingStore, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg11: &0x2::clock::Clock, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_lockdrops(&arg0.hive_entry_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        let v5 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_CONFIGs"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a4c6f636b64726f70205661756c7420416464726573733a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v0));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a2d20486f6c6473206c6f636b65642053554920616e6420646567656e68697665204c5020746f6b656e73206b72616674656420616761696e7374205355492d68697665535549206c6f636b64726f70"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020436f6e6669677320496e697469616c697a65642120"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a4c5344204c6f636b64726f70205661756c743a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v1));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a2d20486f6c647320535549206465706f73697465642062792074686520757365727320647572696e67207765686e20746865204c6f636b64726f70207068617365206973206c6976652e"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a4b726979612041747461636b20436f6e6669673a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v2));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a2d2053746f72657320636f6e66696775726174696f6e20706172616d657465727320666f722076616d706972652d61747461636b206f6e204b7269796120444558"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a466c6f77582041747461636b20436f6e6669673a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v3));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a2d2053746f72657320636f6e66696775726174696f6e20706172616d657465727320666f722076616d706972652d61747461636b206f6e20466c6f775820444558"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a43657475732041747461636b20436f6e6669673a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v4));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a2d2053746f72657320636f6e66696775726174696f6e20706172616d657465727320666f722076616d706972652d61747461636b206f6e20436574757320444558"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg11, arg10, v5.buzz, v5.gen_ai, arg22);
    }

    public entry fun migrate_user_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg7: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::LockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::migrate_user_cetus_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked Cetus NFT positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d204365747573204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72206365747573206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"CETUS_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg7: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::migrate_user_flowx_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked FlowX LP positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d20466c6f7758204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f7220466c6f7758206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"FLOWX_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_kriya_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg7: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaAttackConfig, arg9: &mut 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::migrate_user_kriya_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked Kriya LP positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d204b72697961204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72204b72697961206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"KRIYA_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg7: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::LockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::migrate_user_rev_cetus_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked Cetus NFT positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d204365747573204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72206365747573206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"CETUS_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg7: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::migrate_user_rev_flowx_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked FlowX LP positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d20466c6f7758204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f7220466c6f7758206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"FLOWX_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_sui_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg7: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropVault, arg8: &mut 0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::migrate_user_sui_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(x"436f6e67726174756c6174696f6e732120535549206c6f636b757020706f736974696f6e73207375636365737366756c6c792066696e616c697a656421200a0a");
        0x1::string::append(&mut v7, 0x1::string::utf8(b"SUI Locked  "));
        0x1::string::append(&mut v7, make_num_with_decimals((v0 as u128), (9 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" SUI "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d20535549204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72207468652075736572203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"SUI_HIVE_SUI_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun claim_bees_for_farming(arg0: &mut HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg2: &mut 0x2::token::TokenPolicy<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg3: &0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg1);
        authority_check(v2, v3, 0x2::tx_context::sender(arg4));
        let v4 = 0x2::tx_context::epoch(arg4);
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg1, arg4);
        if (v5.active_epoch < v4) {
            let v6 = compute_bees_farmed(arg0, &v5.engagement_metrics, v1, v0, v5.active_epoch);
            0x2::linked_table::push_back<u64, u64>(&mut v5.engagement_metrics.bees_farmed, v5.active_epoch, v6);
            v5.engagement_metrics.bees_to_claim = v5.engagement_metrics.bees_to_claim + v6;
            v5.active_epoch = v4;
            let v7 = &mut v5.engagement_metrics;
            reset_engagement_info(v7);
        };
        if (v5.engagement_metrics.bees_to_claim > 0) {
            let v8 = 0x2::balance::split<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>(&mut arg0.total_bees_available, v5.engagement_metrics.bees_to_claim);
            let v9 = ClaimBeesFromFarming{
                bees_farmed  : 0x2::balance::value<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>(&v8),
                username     : v1,
                profile_addr : v0,
            };
            0x2::event::emit<ClaimBeesFromFarming>(v9);
            0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::transfer_bees_balance(arg2, arg3, v8, 0x2::tx_context::sender(arg4), arg4);
        };
    }

    public entry fun claim_pol_from_streamer_buzz<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::PoolRegistry, arg5: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg6: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T0, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::claim_pol_from_streamer_buzz<T0>(arg1, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg3, arg5, arg6, arg7);
        let v2 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"POL_INFUSED_IN_POOL"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a0a0a5355492d48495645204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v2.buzz, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a0a0a5355492d424545204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v2.buzz, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v2.buzz, v2.gen_ai, arg7);
    }

    public entry fun claim_rewards_and_shares_0_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg5: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg7: &0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::claim_rewards_and_shares_0_fruits<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9);
        let (_, v6, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v9 = make_buzz_for_infusion_rewards_claim(v6, v0, v1, v2, v3, v4);
        let v10 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v11 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v10);
        0x1::string::append(&mut v9, v11.buzz);
        let v12 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v6, v12, v10, v9, v11.gen_ai);
    }

    public entry fun claim_rewards_and_shares_1_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg5: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg7: &0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::claim_rewards_and_shares_1_fruits<T0, T1>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9);
        let (_, v7, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v7, v0, v1, v2, v3, v4);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v12 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v11);
        0x1::string::append(&mut v10, v12.buzz);
        let v13 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v13, v11, v10, v12.gen_ai);
    }

    public entry fun claim_rewards_and_shares_2_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg5: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg7: &0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, _, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::claim_rewards_and_shares_2_fruits<T0, T1, T2>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9);
        let (_, v8, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v11 = make_buzz_for_infusion_rewards_claim(v8, v0, v1, v2, v3, v4);
        let v12 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v13 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v12);
        0x1::string::append(&mut v11, v13.buzz);
        let v14 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v8, v14, v12, v11, v13.gen_ai);
    }

    public entry fun claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg5: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg7: &0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, _, _, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9);
        let (_, v9, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v12 = make_buzz_for_infusion_rewards_claim(v9, v0, v1, v2, v3, v4);
        let v13 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v14 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v13);
        0x1::string::append(&mut v12, v14.buzz);
        let v15 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v9, v15, v13, v12, v14.gen_ai);
    }

    public entry fun delegate_hive_airdrop<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::delegate_hive_airdrop<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(x"2a2a5355492d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" HIVE delegated from airdrop rewards for Infusion phase"));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v7, 0x1::string::utf8(b"DELEGATE_HIVE_AIRDROP"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun delegate_hive_from_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::delegate_hive_from_lockdrop<T0>(arg0, &arg1.hive_entry_cap, &arg1.infusion_vault_dof_manager_cap, arg2, arg3, arg4, arg5, arg6);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(x"2a2a5355492d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" HIVE delegated from lockdrop rewards for Infusion phase"));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"DELEGATE_HIVE_LOCKDROP"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun infuse_hive_incentives<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::infuse_hive_incentives<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, arg2, arg3, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INFUSE_HIVE_INCENTIVES"));
        let v1 = make_num_with_decimals((arg5 as u128), 6);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"HIVE tokens have been added as rewards for our Infusion Phase! "));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v1, v0.gen_ai, arg6);
    }

    public entry fun infuse_sui_hive_pool<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: 0x2::coin::TreasuryCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg6: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg7: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T0, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg8: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::PoolRegistry, arg9: &mut 0x6d76201f395d3af28b7df313fef310d8400bb19887727157290325540a8481c1::three_pool::PoolRegistry, arg10: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::infuse_sui_hive_pool<T0>(arg1, &arg0.hive_entry_cap, arg5, arg3, arg2, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg4, arg6, arg7, arg8, arg9, arg10, arg11);
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"SUI_HIVE_POOL_INFUSED"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a0a0a53554920496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v0 as u128), 9));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a4849564520496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" HIVE"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a4c5020746f6b656e73204b726166746564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a0a0a5355492d42454520504f4f4c20494e4655534544202d20"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a0a0a53554920496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v3 as u128), 9));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a42454520496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v4 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" BEEs"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a4c5020746f6b656e73204b726166746564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v5 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg5, v6.buzz, v6.gen_ai, arg11);
    }

    public entry fun initialize_infusion_vault<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg4: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfileMappingStore, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::initialize_infusion_vault<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg4, arg5, arg6, arg7, arg2, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_INFUSION_VAULT"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg17);
    }

    public entry fun new_infuse_sui_hive_pool<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropRewardsCapabilityHolder, arg3: 0x2::coin::TreasuryCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg6: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg7: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LiquidityPool<T0, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>, arg8: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::PoolRegistry, arg9: &mut 0x6d76201f395d3af28b7df313fef310d8400bb19887727157290325540a8481c1::three_pool::PoolRegistry, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::new_infuse_sui_hive_pool<T0>(arg1, &arg0.hive_entry_cap, arg5, arg3, arg2, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg4, arg6, arg7, arg8, arg9, arg10);
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"SUI_HIVE_POOL_INFUSED"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a0a0a53554920496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v0 as u128), 9));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a4849564520496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" HIVE"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a4c5020746f6b656e73204b726166746564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a0a0a5355492d42454520504f4f4c20494e4655534544202d20"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a0a0a53554920496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v3 as u128), 9));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a42454520496e6675736564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v4 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" BEEs"));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(x"0a4c5020746f6b656e73204b726166746564202d20"));
        0x1::string::append(&mut v6.buzz, make_num_with_decimals((v5 as u128), 6));
        0x1::string::append(&mut v6.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg5, v6.buzz, v6.gen_ai, arg10);
    }

    public entry fun stake_lp_tokens_0_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg3: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::stake_lp_tokens_0_fruits<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_one_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg3: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::stake_lp_tokens_one_fruits<T0, T1>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_three_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg3: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::stake_lp_tokens_three_fruits<T0, T1, T2, T3>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_two_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolsGovernor, arg3: &mut 0x982761643694ac23004ed40b23b3c66f603435be454204c619af183be226604a::dex_dao::PoolHive<0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::LP<T0, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE, 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::stake_lp_tokens_two_fruits<T0, T1, T2>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun update_staked_shares<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::update_staked_shares<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2);
    }

    public entry fun withdraw_hive<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::withdraw_hive<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3);
    }

    public fun kraft_hive_assets_and_return_sui(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (_, v1, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg8);
        let v4 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::kraft_hive_assets_and_return_sui(&arg0.hive_entry_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v5 = 0x1::string::utf8(b"KRAFT_HIVE_ASSET::");
        0x1::string::append(&mut v5, arg6);
        0x1::string::append(&mut v5, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v5, arg7);
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v5);
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg8, arg12);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v7, 0, v5, v6.buzz, v6.gen_ai, false, arg12);
        v4
    }

    public entry fun add_entry_to_buzz_chain(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfileMappingStore, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        authority_check(v2, v3, 0x2::tx_context::sender(arg6));
        let v4 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_kiosks_list_for_creator(arg2, v0);
        assert!(0x1::vector::length<address>(&v4) > 0, 9753);
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg3, arg6);
        let v6 = 0x2::tx_context::epoch(arg6);
        add_to_buzz_chain(v6, 0x2::clock::timestamp_ms(arg0), v1, v5, arg4, arg5, arg6);
    }

    public entry fun add_like_to_buzz(arg0: &0x2::clock::Clock, arg1: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let (v4, v5, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        assert!(v3 == 0x2::tx_context::sender(arg8), 9751);
        assert!(!v2, 9754);
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg4, arg8);
        if (arg5 == 0) {
            let v9 = 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v8.noise_buzzes, arg6);
            assert!(!0x2::linked_table::contains<address, bool>(&v9.likes, v0), 9750);
            0x2::linked_table::push_back<address, bool>(&mut v9.likes, v0, true);
        } else if (arg5 == 1) {
            let v10 = 0x2::linked_table::borrow_mut<u64, UserChronicleBuzz>(&mut v8.chronicle_buzzes, arg6);
            assert!(!0x2::linked_table::contains<address, bool>(&v10.likes, v0), 9750);
            0x2::linked_table::push_back<address, bool>(&mut v10.likes, v0, true);
        } else {
            assert!(arg5 == 2, 9757);
            let v11 = 0x1::vector::borrow_mut<BuzzChain>(0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut v8.buzz_chains, arg6), arg7);
            assert!(!0x2::linked_table::contains<address, bool>(&v11.appreciations, v0), 9750);
            0x2::linked_table::push_back<address, bool>(&mut v11.appreciations, v0, true);
        };
        let v12 = 0x2::tx_context::epoch(arg8);
        manage_new_like(v12, arg2, v8, v5, v4, false, arg8);
        let v13 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg3, arg8);
        manage_new_like(v12, arg2, v13, v1, v0, true, arg8);
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::chronicle_update_on_engagement(&arg2.hive_entry_cap, arg0, arg1, arg3, 1, arg8);
        let v14 = BuzzLiked{
            liked_by_username     : v1,
            poster_username       : v5,
            liked_by_profile_addr : v0,
            poster_profile_addr   : v4,
            buzz_type             : arg5,
            buzz_index            : arg6,
            thread_index          : arg7,
        };
        0x2::event::emit<BuzzLiked>(v14);
    }

    fun add_to_buzz_chain(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut HiveChronicles, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg4) < 1040, 9756);
        let v0 = BuzzChain{
            timestamp     : arg1,
            narrative     : arg4,
            gen_ai        : arg5,
            appreciations : 0x2::linked_table::new<address, bool>(arg6),
            dialogues     : 0x2::linked_table::new<address, Dialogue>(arg6),
        };
        let v1 = 0;
        if (0x2::linked_table::contains<u64, vector<BuzzChain>>(&arg3.buzz_chains, arg0)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut arg3.buzz_chains, arg0);
            let v3 = 0x1::vector::length<BuzzChain>(v2);
            v1 = v3;
            assert!(v3 < 24, 9755);
            0x1::vector::push_back<BuzzChain>(v2, v0);
        } else {
            let v4 = 0x1::vector::empty<BuzzChain>();
            0x1::vector::push_back<BuzzChain>(&mut v4, v0);
            0x2::linked_table::push_back<u64, vector<BuzzChain>>(&mut arg3.buzz_chains, arg0, v4);
        };
        let v5 = NewBuzzChainEntry{
            timestamp   : arg1,
            epoch       : arg0,
            entry_index : v1,
            username    : arg2,
            content     : arg4,
            gen_ai      : arg5,
        };
        0x2::event::emit<NewBuzzChainEntry>(v5);
    }

    public entry fun add_to_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::add_to_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v1, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"2a2a5355492d68697665535549204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v4, make_num_with_decimals((arg5 as u128), 9));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" SUI Locked for "));
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v4, 0x1::string::utf8(x"205765656b7321200a"));
        0x1::string::append(&mut v4, 0x1::string::utf8(b"Pro-rata SUI-hiveSUI degenhive LP tokens and vested HIVE rewards to be received will be calculated ofter the lockdrop phase is over! #DegenHiveOdyssey"));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v1, v5, 0x1::string::utf8(b"ADD_SUI_FOR_LSD_LOCKDROP"), v4, 0x1::option::none<0x1::string::String>());
    }

    public entry fun add_welcome_buzz(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ChronicleBuzz{
            user_log : arg3,
            gen_ai   : 0x1::option::some<0x1::string::String>(arg4),
        };
        let (v1, _) = 0x1::vector::index_of<0x1::string::String>(&arg1.welcome_buzzes_list, &arg2);
        if (v1) {
            *0x2::linked_table::borrow_mut<0x1::string::String, ChronicleBuzz>(&mut arg1.welcome_buzzes, arg2) = v0;
        } else {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.welcome_buzzes_list, arg2);
            0x2::linked_table::push_back<0x1::string::String, ChronicleBuzz>(&mut arg1.welcome_buzzes, arg2, v0);
        };
    }

    fun authority_check(arg0: bool, arg1: address, arg2: address) {
        assert!(arg0 || arg1 == arg2, 9752);
    }

    fun calculate_bees_farmed(arg0: &BeesFarmingSnapshot, arg1: &EngagementInfo) : (u64, u64) {
        let v0 = 0;
        if (arg0.bees_per_like > 0) {
            v0 = (0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::math::mul_div_u256(((arg1.likes_made + arg1.likes_earned) as u256), (1000000000 as u256), arg0.bees_per_like) as u64);
        };
        let v1 = 0;
        if (arg0.bees_per_dialogue > 0) {
            v1 = (0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::math::mul_div_u256(((arg1.dialogues_made + arg1.dialogues_earned) as u256), (1000000000 as u256), arg0.bees_per_dialogue) as u64);
        };
        (v0, v1)
    }

    fun calculate_bees_per_like(arg0: u64, arg1: u64) : u256 {
        if (arg1 > 0) {
            return 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::math::mul_div_u256((arg0 as u256), (1000000000 as u256), (arg1 as u256))
        };
        0
    }

    public fun castVote_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg5);
        authority_check(v2, v3, 0x2::tx_context::sender(arg8));
        let v4 = 0x1::string::utf8(b"MAKE_VOTE_ON_HIVE_DAO_PROPOSAL::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg6 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg5, arg8);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, 0, v4, arg2, arg3, true, arg8);
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::castVote(arg1, arg4, arg6, arg5, arg7, arg8);
    }

    fun compute_bees_farmed(arg0: &HiveChroniclesVault, arg1: &EngagementInfo, arg2: 0x1::string::String, arg3: address, arg4: u64) : u64 {
        let (v0, v1) = calculate_bees_farmed(0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, arg4), arg1);
        let v2 = BeesFarmedByProfileComputed{
            username            : arg2,
            profile_addr        : arg3,
            for_epoch           : arg4,
            likes_made          : arg1.likes_made,
            likes_earned        : arg1.likes_earned,
            dialogues_made      : arg1.dialogues_made,
            dialogues_earned    : arg1.dialogues_earned,
            bees_from_likes     : v0,
            bees_from_dialogues : v1,
        };
        0x2::event::emit<BeesFarmedByProfileComputed>(v2);
        v0 + v1
    }

    fun destroy_dialogue(arg0: Dialogue, arg1: &mut 0x2::tx_context::TxContext) {
        let Dialogue {
            dialogue : _,
            upvotes  : v1,
        } = arg0;
        0x2::linked_table::drop<address, bool>(v1);
    }

    public fun get_hive_chronicle_for_profile(arg0: &mut HiveChroniclesVault, arg1: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg2: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, bool, u64, u64) {
        let v0 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::borrow_from_profile<HiveChronicles>(arg1, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_hive_app_name(&arg0.hive_chronicle_dof_cap));
        let v1 = 0;
        if (v0.active_epoch < 0x2::tx_context::epoch(arg2) && 0x2::linked_table::contains<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, v0.active_epoch)) {
            let (v2, v3) = calculate_bees_farmed(0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, v0.active_epoch), &v0.engagement_metrics);
            v1 = v2 + v3;
        };
        (v0.active_epoch, v0.engagement_metrics.likes_made, v0.engagement_metrics.likes_earned, v0.engagement_metrics.dialogues_made, v0.engagement_metrics.dialogues_earned, v0.engagement_metrics.bees_to_claim + v1, 0x2::linked_table::length<u64, UserNoiseBuzz>(&v0.noise_buzzes), v0.last_noise_epoch, v0.noise_count, 0x2::linked_table::length<u64, UserChronicleBuzz>(&v0.chronicle_buzzes), v0.last_chronicle_epoch, v0.chronicle_count, 0x2::linked_table::length<u64, vector<BuzzChain>>(&v0.buzz_chains), v0.last_buzz_epoch, v0.buzz_count, v0.subscribers_only, 0x2::linked_table::length<u64, UserInfusionBuzz>(&v0.infusion_buzzes), v0.infusion_count)
    }

    public fun get_new_hive_chronicle_for_profile(arg0: &0x2::clock::Clock, arg1: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, bool, u64, u64) {
        let v0 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::borrow_from_profile<HiveChronicles>(arg3, 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_hive_app_name(&arg2.hive_chronicle_dof_cap));
        let v1 = 0;
        if (v0.active_epoch < 0x2::tx_context::epoch(arg4) && 0x2::linked_table::contains<u64, BeesFarmingSnapshot>(&arg2.bees_farming_snampshots, v0.active_epoch)) {
            let (v2, v3) = calculate_bees_farmed(0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg2.bees_farming_snampshots, v0.active_epoch), &v0.engagement_metrics);
            v1 = v2 + v3;
        };
        let v4 = v0.engagement_metrics.bees_to_claim + v1;
        let (v5, v6, v7) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::compute_profile_socialfi_info(arg0, arg1, arg3, arg4);
        (v0.active_epoch, v5, v6, v7, v0.engagement_metrics.likes_made, v0.engagement_metrics.likes_earned, v0.engagement_metrics.dialogues_made, v0.engagement_metrics.dialogues_earned, v4, 0x2::linked_table::length<u64, UserNoiseBuzz>(&v0.noise_buzzes), v0.last_noise_epoch, v0.noise_count, 0x2::linked_table::length<u64, UserChronicleBuzz>(&v0.chronicle_buzzes), v0.last_chronicle_epoch, v0.chronicle_count, 0x2::linked_table::length<u64, vector<BuzzChain>>(&v0.buzz_chains), v0.last_buzz_epoch, v0.buzz_count, v0.subscribers_only, 0x2::linked_table::length<u64, UserInfusionBuzz>(&v0.infusion_buzzes), v0.infusion_count)
    }

    public entry fun increment_bee_farm_epoch<T0>(arg0: &mut HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut 0x2::token::TokenPolicy<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg3: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::BeeCap<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        if (v0 > arg0.bee_farm_info.active_epoch) {
            let v1 = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::claim_bees_for_farming<T0>(&arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg1, arg4);
            let v2 = 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::bee_trade::burn_bees_from_supply(arg2, arg3, arg4);
            let v3 = calculate_bees_per_like(arg0.bee_farm_info.bees_for_epoch / 2, arg0.bee_farm_info.likes_during_epoch);
            let v4 = calculate_bees_per_like(arg0.bee_farm_info.bees_for_epoch / 2, arg0.bee_farm_info.dialogues_during_epoch);
            let v5 = BeeFarmDistributionEpochElapsed{
                epoch_over                  : arg0.bee_farm_info.active_epoch,
                likes_farmed                : arg0.bee_farm_info.likes_during_epoch,
                dialogues_farmed            : arg0.bee_farm_info.dialogues_during_epoch,
                bees_distributed            : arg0.bee_farm_info.bees_for_epoch,
                bees_per_like               : v3,
                bees_per_dialogue           : v4,
                bees_burnt                  : v2,
                next_epoch_bees_for_farming : 0x2::balance::value<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>(&v1),
            };
            0x2::event::emit<BeeFarmDistributionEpochElapsed>(v5);
            let v6 = BeesFarmingSnapshot{
                epoch             : arg0.bee_farm_info.active_epoch,
                bees_distributed  : arg0.bee_farm_info.bees_for_epoch,
                likes_farmed      : arg0.bee_farm_info.likes_during_epoch,
                dialogues_farmed  : arg0.bee_farm_info.dialogues_during_epoch,
                bees_per_like     : v3,
                bees_per_dialogue : v4,
                bees_burnt        : v2,
            };
            0x2::linked_table::push_back<u64, BeesFarmingSnapshot>(&mut arg0.bees_farming_snampshots, arg0.bee_farm_info.active_epoch, v6);
            arg0.bee_farm_info.active_epoch = v0;
            arg0.bee_farm_info.bees_for_epoch = 0x2::balance::value<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>(&v1);
            arg0.bee_farm_info.likes_during_epoch = 0;
            arg0.bee_farm_info.dialogues_during_epoch = 0;
            0x2::balance::join<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>(&mut arg0.total_bees_available, v1);
        };
    }

    public fun infuse_gems_into_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg8);
        authority_check(v2, v3, 0x2::tx_context::sender(arg11));
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::infuse_gems_into_asset(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v4 = 0x1::string::utf8(b"INFUSE_GEMS_INTO_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg10 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg8, arg11);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg10, v4, arg2, arg3, true, arg11);
    }

    public entry fun infuse_sui<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::deposit_sui<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(x"2a2a5355492d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), 9));
        0x1::string::append(&mut v6, v3);
        0x1::string::append(&mut v6, 0x1::string::utf8(b"  SUI infused for SUI-HIVE pool."));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v7, 0x1::string::utf8(b"INFUSE_SUI"), v6, 0x1::option::none<0x1::string::String>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_rev_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg3: &0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HIVE>, arg9: u64, arg10: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        let v1 = 0x1::string::utf8(b"Vampire Attack on Cetus DEX's ");
        0x1::string::append(&mut v1, arg6);
        0x1::string::append(&mut v1, v0.buzz);
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204365747573204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v1, 0x2::address::to_string(0x2b21ac7b574183dcf76b750c97209058157209ba7f7095b73638cafd9b17bc43::lockdrop::initialize_attack_on_reverse_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v1, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE "));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v1, v0.gen_ai, arg11);
    }

    public entry fun initialize_hive_chronicles(arg0: 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::HiveEntryCap, arg1: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveAppAccessCapability, arg2: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::ManagerAppAccessCapability, arg3: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::ManagerAppAccessCapability, arg4: 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::ManagerAppAccessCapability, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BeeFarmInfo{
            active_epoch           : 0x2::tx_context::epoch(arg5),
            bees_for_epoch         : 0,
            likes_during_epoch     : 0,
            dialogues_during_epoch : 0,
        };
        let v1 = HiveChroniclesVault{
            id                             : 0x2::object::new(arg5),
            hive_entry_cap                 : arg0,
            hive_chronicle_dof_cap         : arg1,
            airdrop_vault_dof_manager_cap  : arg2,
            lockdrop_vault_dof_manager_cap : arg3,
            infusion_vault_dof_manager_cap : arg4,
            system_infusion_buzzes         : 0x2::linked_table::new<0x1::string::String, InfusionBuzz>(arg5),
            hive_chronicle_buzzes          : 0x2::linked_table::new<0x1::string::String, ChronicleBuzz>(arg5),
            welcome_buzzes                 : 0x2::linked_table::new<0x1::string::String, ChronicleBuzz>(arg5),
            welcome_buzzes_list            : 0x1::vector::empty<0x1::string::String>(),
            total_bees_available           : 0x2::balance::zero<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::bee::BEE>(),
            bee_farm_info                  : v0,
            bees_farming_snampshots        : 0x2::linked_table::new<u64, BeesFarmingSnapshot>(arg5),
        };
        0x2::transfer::share_object<HiveChroniclesVault>(v1);
    }

    public fun initialize_skin_for_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg5);
        authority_check(v2, v3, 0x2::tx_context::sender(arg8));
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::initialize_skin_for_asset(arg4, arg5, arg6, arg7, arg8);
        let v4 = 0x1::string::utf8(b"INITIALIZE_SKIN_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg7 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg5, arg8);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg7, v4, arg2, arg3, true, arg8);
    }

    fun internal_kraft_cetus_claim_liquidity_stream<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: u8, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_LIQUIDITY_CLAIMED"));
        0x1::string::append(&mut arg3, v0.buzz);
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut arg3, 0x1::string::utf8(b"Total Liquidity deposited for the lockdrop: "));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg9 as u128), (arg6 as u64)));
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"204345545553204c500a0a"));
        0x1::string::append(&mut arg3, arg4);
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" Liquidity withdrawn from Cetus: "));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg10 as u128), (arg7 as u64)));
        0x1::string::append(&mut arg3, arg4);
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg3, arg5);
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" Liquidity withdrawn from Cetus: "));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg11 as u128), (arg8 as u64)));
        0x1::string::append(&mut arg3, arg5);
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut arg3, arg4);
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" trading fee earned by cetus: "));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg12 as u128), (arg7 as u64)));
        0x1::string::append(&mut arg3, arg4);
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg3, arg5);
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" trading fee earned by cetus: "));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg13 as u128), (arg8 as u64)));
        0x1::string::append(&mut arg3, arg5);
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut arg3, 0x1::string::utf8(b"- SUI Earned as rewards: "));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg14 as u128), (9 as u64)));
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a202d204345545553204561726e656420617320726577617264733a20"));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg15 as u128), (9 as u64)));
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" CETUS"));
        0x1::string::append(&mut arg3, 0x1::string::utf8(x"0a0a546f74616c204849564520696e63656e746976657320666f72204365747573204c6f636b64726f703a20"));
        0x1::string::append(&mut arg3, make_num_with_decimals((arg16 as u128), (6 as u64)));
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" HIVE"));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg2, arg1, arg3, v0.gen_ai, arg17);
    }

    public entry fun kraft_hive_profile(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfileMappingStore, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let v1 = kraft_new_hive_chronicle(arg10, v0);
        let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.welcome_buzzes_list, ((0x2::clock::timestamp_ms(arg1) % 0x1::vector::length<0x1::string::String>(&arg0.welcome_buzzes_list)) as u64));
        let v3 = *0x2::linked_table::borrow<0x1::string::String, ChronicleBuzz>(&arg0.welcome_buzzes, v2);
        let v4 = &mut v1;
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), arg8, v4, 0, v2, v3.user_log, v3.gen_ai, false, arg10);
        let v5 = NewChronicleBuzz{
            username  : arg8,
            log_index : 0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
            asset_id  : 0,
            move_type : v2,
            user_log  : v3.user_log,
            gen_ai    : v3.gen_ai,
        };
        0x2::event::emit<NewChronicleBuzz>(v5);
        0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::kraft_hive_profile_and_return_sui<HiveChronicles>(&arg0.hive_entry_cap, &arg0.hive_chronicle_dof_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v1, arg10), 0x2::tx_context::sender(arg10), arg10);
    }

    fun kraft_new_hive_chronicle(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : HiveChronicles {
        let v0 = EngagementInfo{
            likes_made       : 0,
            likes_earned     : 0,
            dialogues_made   : 0,
            dialogues_earned : 0,
            bees_farmed      : 0x2::linked_table::new<u64, u64>(arg0),
            bees_to_claim    : 0,
        };
        HiveChronicles{
            id                   : 0x2::object::new(arg0),
            active_epoch         : arg1,
            engagement_metrics   : v0,
            noise_buzzes         : 0x2::linked_table::new<u64, UserNoiseBuzz>(arg0),
            last_noise_epoch     : arg1,
            noise_count          : 0,
            chronicle_buzzes     : 0x2::linked_table::new<u64, UserChronicleBuzz>(arg0),
            last_chronicle_epoch : arg1,
            chronicle_count      : 0,
            buzz_chains          : 0x2::linked_table::new<u64, vector<BuzzChain>>(arg0),
            last_buzz_epoch      : arg1,
            buzz_count           : 0,
            subscribers_only     : false,
            infusion_buzzes      : 0x2::linked_table::new<u64, UserInfusionBuzz>(arg0),
            infusion_count       : 0,
        }
    }

    public fun kraft_new_skin_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg7: &0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveSkinKraftCap, arg8: 0x1::string::String, arg9: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg10: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>, 0x1::string::String, 0x1::string::String, u64) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg5);
        authority_check(v2, v3, 0x2::tx_context::sender(arg12));
        let v4 = 0x1::string::utf8(b"KRAFT_NEW_SKIN_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg11 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg5, arg12);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg11, v4, arg2, arg3, true, arg12);
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::kraft_new_skin(arg4, arg1, arg7, arg9, arg10, arg5, arg6, arg8, arg11, arg12)
    }

    public entry fun lock_flowx_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::lock_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** FlowX's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg6 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens withdrawn from FlowX lockup of "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" weeks!"));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_ADDED_FOR_FLOWX"), v6, 0x1::option::none<0x1::string::String>());
    }

    public fun lock_hive_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg8);
        authority_check(v2, v3, 0x2::tx_context::sender(arg11));
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::lock_hive_asset(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v4 = 0x1::string::utf8(b"LOCK_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg9 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg8, arg11);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg9, v4, arg2, arg3, true, arg11);
    }

    public entry fun lock_in_x_bee_pool_addr<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg6: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg7: &mut 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::Config, arg8: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::PoolRegistry, arg9: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: vector<u64>, arg13: 0x1::option::Option<vector<u256>>, arg14: 0x1::option::Option<vector<u64>>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"LOCK_IN_X_HIVE_POOL_ADDR"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a5355492d42454520506f6f6c3a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::lock_in_sui_bee_pool_addr<T0, T1, T2>(arg2, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg3, arg4, arg6, arg7, arg8, arg9, 0x2::coin::into_balance<0x2::sui::SUI>(arg10), arg11, arg12, arg13, arg14, arg15)));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg2, arg5, v0.buzz, v0.gen_ai, arg15);
    }

    public entry fun lock_in_x_hive_pool_addr<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::HiveVault, arg6: &mut 0x4a5ce2acae62bb36568fe2c02d1e07c29d1527210ea4ceb3a1550a2cdee2b785::hsui_vault::HSuiVault, arg7: &mut 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::Config, arg8: &mut 0x16104e30d566fa7239af9acff9778ed4394c7941484f93dc25ac1a04c37095ed::two_pool::PoolRegistry, arg9: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: vector<u64>, arg13: 0x1::option::Option<vector<u256>>, arg14: 0x1::option::Option<vector<u64>>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"LOCK_IN_X_HIVE_POOL_ADDR"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a5355492d4849564520506f6f6c3a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::lock_in_sui_hive_pool_addr<T0, T1, T2>(arg2, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg3, arg4, arg6, arg7, arg8, arg9, 0x2::coin::into_balance<0x2::sui::SUI>(arg10), arg11, arg12, arg13, arg14, arg15)));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg2, arg5, v0.buzz, v0.gen_ai, arg15);
    }

    public entry fun lock_kriya_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::lock_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** Kriya's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg6 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens Locked for "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"205765656b7321200a"));
        0x1::string::append(&mut v6, 0x1::string::utf8(b"Pro-rata degenhive LP tokens and vested HIVE rewards to be received will be calculated ofter the lockdrop phase is over! #DegenHiveOdyssey"));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_DEPOSITED_TO_KRIYA"), v6, 0x1::option::none<0x1::string::String>());
    }

    fun make_buzz_for_infusion_rewards_claim(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"- [INFUSION-BUZZ] #");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  claimed rewards and shares for participation in SUI-HIVE Infusion -::- "));
        if (arg3 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a484956452047454d5320636c61696d65642061732070617274696369706174696f6e2072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg3 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE_GEMS"));
        };
        if (arg4 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a42454520546f6b656e7320636c61696d65642061732070617274696369706174696f6e2072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg4 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" BEEs"));
        };
        if (arg2 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a484956452047454d5320636c61696d6564206173207374616b696e672072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg2 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE_GEMS"));
        };
        if (arg1 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5355492d48495645204c5020546f6b656e7320756e626f6e646564202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg1 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens"));
        };
        if (arg5 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5355492d48495645204c5020546f6b656e7320756e6c6f636b6564202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg5 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens"));
        };
        v0
    }

    public fun make_listing_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::MarketPlace<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: bool, arg14: bool, arg15: bool, arg16: u8, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg8);
        authority_check(v2, v3, 0x2::tx_context::sender(arg19));
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::make_listing(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v4 = 0x1::string::utf8(b"LIST_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg9 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg8, arg19);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg9, v4, arg2, arg3, true, arg19);
    }

    fun make_new_chronicle_log(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            assert!(0x1::string::length(&arg5) < 510, 9746);
        };
        let v0 = 0x2::linked_table::length<u64, UserChronicleBuzz>(&arg2.chronicle_buzzes);
        let v1 = UserChronicleBuzz{
            timestamp : arg0,
            asset_id  : arg3,
            move_type : arg4,
            user_log  : arg5,
            gen_ai    : arg6,
            likes     : 0x2::linked_table::new<address, bool>(arg8),
            dialogues : 0x2::linked_table::new<address, Dialogue>(arg8),
        };
        0x2::linked_table::push_back<u64, UserChronicleBuzz>(&mut arg2.chronicle_buzzes, v0, v1);
        let v2 = NewChronicleBuzz{
            username  : arg1,
            log_index : v0,
            timestamp : arg0,
            asset_id  : arg3,
            move_type : arg4,
            user_log  : arg5,
            gen_ai    : arg6,
        };
        0x2::event::emit<NewChronicleBuzz>(v2);
    }

    fun make_new_infusion_buzz(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>) {
        let v0 = arg2.infusion_count;
        let v1 = UserInfusionBuzz{
            timestamp     : arg0,
            infusion_type : arg3,
            buzz          : arg4,
            gen_ai        : arg5,
        };
        0x2::linked_table::push_back<u64, UserInfusionBuzz>(&mut arg2.infusion_buzzes, v0, v1);
        arg2.infusion_count = arg2.infusion_count + 1;
        let v2 = NewInfusionBuzz{
            username       : arg1,
            infusion_count : v0,
            timestamp      : arg0,
            infusion_type  : arg3,
            buzz           : arg4,
            gen_ai         : arg5,
        };
        0x2::event::emit<NewInfusionBuzz>(v2);
    }

    fun make_new_noise(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut HiveChronicles, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg4) < 240, 9747);
        if (arg0 == arg3.last_noise_epoch) {
            arg3.noise_count = arg3.noise_count + 1;
            assert!(arg3.noise_count < 5, 9748);
        } else {
            arg3.last_noise_epoch = arg0;
            arg3.noise_count = 1;
        };
        let v0 = 0x2::linked_table::length<u64, UserNoiseBuzz>(&arg3.noise_buzzes);
        let v1 = UserNoiseBuzz{
            timestamp : arg1,
            epoch     : arg0,
            noise     : arg4,
            gen_ai    : arg5,
            likes     : 0x2::linked_table::new<address, bool>(arg6),
            dialogues : 0x2::linked_table::new<address, Dialogue>(arg6),
        };
        0x2::linked_table::push_back<u64, UserNoiseBuzz>(&mut arg3.noise_buzzes, v0, v1);
        let v2 = NewNoiseBuzz{
            username    : arg2,
            noise_index : v0,
            timestamp   : arg1,
            epoch       : arg0,
            noise       : arg4,
            gen_ai      : arg5,
        };
        0x2::event::emit<NewNoiseBuzz>(v2);
    }

    fun make_num_with_decimals(arg0: u128, arg1: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::math::pow(10, (arg1 as u128));
        let v1 = 0x1::string::utf8(u64_to_ascii(((arg0 / v0) as u64)));
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v1, 0x1::string::utf8(u64_to_ascii(((arg0 % v0) as u64))));
        v1
    }

    public entry fun make_some_noise(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg2);
        authority_check(v2, v3, 0x2::tx_context::sender(arg5));
        let v4 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg2, arg5);
        let v5 = 0x2::tx_context::epoch(arg5);
        make_new_noise(v5, 0x2::clock::timestamp_ms(arg0), v1, v4, arg3, arg4, arg5);
    }

    fun manage_new_dialogue(arg0: u64, arg1: &mut HiveChroniclesVault, arg2: &mut HiveChronicles, arg3: 0x1::string::String, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == arg1.bee_farm_info.active_epoch, 9749);
        arg1.bee_farm_info.dialogues_during_epoch = arg1.bee_farm_info.dialogues_during_epoch + 1;
        if (arg2.active_epoch < arg0) {
            let v0 = compute_bees_farmed(arg1, &arg2.engagement_metrics, arg3, arg4, arg2.active_epoch);
            0x2::linked_table::push_back<u64, u64>(&mut arg2.engagement_metrics.bees_farmed, arg2.active_epoch, v0);
            arg2.engagement_metrics.bees_to_claim = arg2.engagement_metrics.bees_to_claim + v0;
            arg2.active_epoch = arg0;
            let v1 = &mut arg2.engagement_metrics;
            reset_engagement_info(v1);
        };
        if (arg5) {
            arg2.engagement_metrics.dialogues_made = arg2.engagement_metrics.dialogues_made + 1;
        } else {
            arg2.engagement_metrics.dialogues_earned = arg2.engagement_metrics.dialogues_earned + 1;
        };
    }

    fun manage_new_like(arg0: u64, arg1: &mut HiveChroniclesVault, arg2: &mut HiveChronicles, arg3: 0x1::string::String, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == arg1.bee_farm_info.active_epoch, 9749);
        arg1.bee_farm_info.likes_during_epoch = arg1.bee_farm_info.likes_during_epoch + 1;
        if (arg2.active_epoch < arg0) {
            let v0 = compute_bees_farmed(arg1, &arg2.engagement_metrics, arg3, arg4, arg2.active_epoch);
            0x2::linked_table::push_back<u64, u64>(&mut arg2.engagement_metrics.bees_farmed, arg2.active_epoch, v0);
            arg2.engagement_metrics.bees_to_claim = arg2.engagement_metrics.bees_to_claim + v0;
            arg2.active_epoch = arg0;
            let v1 = &mut arg2.engagement_metrics;
            reset_engagement_info(v1);
        };
        if (arg5) {
            arg2.engagement_metrics.likes_made = arg2.engagement_metrics.likes_made + 1;
        } else {
            arg2.engagement_metrics.likes_earned = arg2.engagement_metrics.likes_earned + 1;
        };
    }

    public entry fun new_add_system_buzz(arg0: &0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::linked_table::contains<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, arg2)) {
            let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, InfusionBuzz>(&mut arg1.system_infusion_buzzes, arg2);
            v0.buzz = arg3;
            if (arg4 != 0x1::string::utf8(b"")) {
                v0.gen_ai = 0x1::option::some<0x1::string::String>(arg4);
            } else {
                v0.gen_ai = 0x1::option::none<0x1::string::String>();
            };
            v0.gen_ai = 0x1::option::some<0x1::string::String>(arg4);
        } else {
            let v1 = InfusionBuzz{
                buzz   : arg3,
                gen_ai : 0x1::option::none<0x1::string::String>(),
            };
            if (arg4 != 0x1::string::utf8(b"")) {
                v1.gen_ai = 0x1::option::some<0x1::string::String>(arg4);
            };
            0x2::linked_table::push_back<0x1::string::String, InfusionBuzz>(&mut arg1.system_infusion_buzzes, arg2, v1);
        };
    }

    public fun port_gems_for_skin_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg6: &0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveSkinKraftCap, arg7: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg8: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HSuiDisperser<0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hsui::HSUI>, arg9: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveDisperser, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x70c99d68b9af73bb075ec6b1a3d0e980dc89b2450f8333e31ddb4aa6f4aa992d::hive_gems::HiveGems {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg5);
        authority_check(v2, v3, 0x2::tx_context::sender(arg13));
        let v4 = 0x1::string::utf8(b"PORT_GEMS_FOR_SKIN_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg11 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg5, arg13);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg11, v4, arg2, arg3, true, arg13);
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::port_gems_for_skin(arg1, arg4, arg6, arg7, arg8, arg9, arg5, arg10, arg11, arg12, arg13)
    }

    fun reset_engagement_info(arg0: &mut EngagementInfo) {
        arg0.likes_made = 0;
        arg0.likes_earned = 0;
        arg0.dialogues_made = 0;
        arg0.dialogues_earned = 0;
    }

    public entry fun stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::LockdropForPool<T0, T1>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xcebb0dcd7ae010153fbcc116dec56010ff4cda81ad2a06db9ad8c6fc26df607c::cetus_vampire_attack::stake_cetus_position<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v4, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"** CETUS's ");
        0x1::string::append(&mut v7, v1);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" - NFT position with liquidity "));
        0x1::string::append(&mut v7, make_num_with_decimals((v0 as u128), (v2 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" locked for "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"205765656b7321200a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Once locked, cetus LP positions cannot be withdrawn from the Lockdrop pool."));
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"LP_DEPOSITED_FOR_CETUS"), v7, 0x1::option::none<0x1::string::String>());
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun update_config_for_skin_kraft_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveDaoGovernor, arg5: &0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::HiveSkinKraftCap, arg6: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: bool, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg6);
        authority_check(v2, v3, 0x2::tx_context::sender(arg15));
        0xc32f412b9d72eb947a99ec3e6a3e368fe400a70f19a02fca459fe42da8add066::hive_dao::update_config_for_skin_kraft(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v4 = 0x1::string::utf8(b"UPDATE_CONFIG_FOR_SKIN_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg8 as u64))));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg6, arg15);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg8, v4, arg2, arg3, true, arg15);
    }

    public entry fun update_dialogue_to_buzz(arg0: &0x2::clock::Clock, arg1: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: u8, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let (v4, v5, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        assert!(v3 == 0x2::tx_context::sender(arg10), 9751);
        let v8 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg4, arg10);
        if (arg5 == 0) {
            let v9 = 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v8.noise_buzzes, arg6);
            if (arg9) {
                assert!(0x2::linked_table::contains<address, Dialogue>(&v9.dialogues, v0), 9759);
                destroy_dialogue(0x2::linked_table::remove<address, Dialogue>(&mut v9.dialogues, v0), arg10);
            } else {
                let v10 = Dialogue{
                    dialogue : arg8,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                };
                0x2::linked_table::push_back<address, Dialogue>(&mut v9.dialogues, v0, v10);
            };
        } else if (arg5 == 1) {
            let v11 = 0x2::linked_table::borrow_mut<u64, UserChronicleBuzz>(&mut v8.chronicle_buzzes, arg6);
            if (arg9) {
                assert!(0x2::linked_table::contains<address, Dialogue>(&v11.dialogues, v0), 9759);
                destroy_dialogue(0x2::linked_table::remove<address, Dialogue>(&mut v11.dialogues, v0), arg10);
            } else {
                let v12 = Dialogue{
                    dialogue : arg8,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                };
                0x2::linked_table::push_back<address, Dialogue>(&mut v11.dialogues, v0, v12);
            };
        } else {
            assert!(arg5 == 2, 9757);
            let v13 = 0x1::vector::borrow_mut<BuzzChain>(0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut v8.buzz_chains, arg6), arg7);
            if (arg9) {
                assert!(0x2::linked_table::contains<address, Dialogue>(&v13.dialogues, v0), 9759);
                destroy_dialogue(0x2::linked_table::remove<address, Dialogue>(&mut v13.dialogues, v0), arg10);
            } else {
                let v14 = Dialogue{
                    dialogue : arg8,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                };
                0x2::linked_table::push_back<address, Dialogue>(&mut v13.dialogues, v0, v14);
            };
        };
        let v15 = 0x2::tx_context::epoch(arg10);
        manage_new_dialogue(v15, arg2, v8, v5, v4, false, arg10);
        let v16 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg3, arg10);
        manage_new_dialogue(v15, arg2, v16, v1, v0, true, arg10);
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::chronicle_update_on_engagement(&arg2.hive_entry_cap, arg0, arg1, arg3, 1, arg10);
        let v17 = DialogueAdded{
            by_username         : v1,
            by_profile_addr     : v0,
            poster_username     : v5,
            poster_profile_addr : v4,
            buzz_type           : arg5,
            buzz_index          : arg6,
            thread_index        : arg7,
            dialogue            : arg8,
            to_remove           : arg9,
        };
        0x2::event::emit<DialogueAdded>(v17);
    }

    public entry fun upvote_dialogue_to_buzz(arg0: &0x2::clock::Clock, arg1: &0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg6: u8, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let (v4, v5, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let (v8, v9, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg5);
        assert!(v3 == 0x2::tx_context::sender(arg9), 9751);
        let v12 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg4, arg9);
        if (arg6 == 0) {
            let v13 = 0x2::linked_table::borrow_mut<address, Dialogue>(&mut 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v12.noise_buzzes, arg7).dialogues, v8);
            assert!(!0x2::linked_table::contains<address, bool>(&v13.upvotes, v0), 9758);
            0x2::linked_table::push_back<address, bool>(&mut v13.upvotes, v0, true);
        } else if (arg6 == 1) {
            let v14 = 0x2::linked_table::borrow_mut<address, Dialogue>(&mut 0x2::linked_table::borrow_mut<u64, UserChronicleBuzz>(&mut v12.chronicle_buzzes, arg7).dialogues, v8);
            assert!(!0x2::linked_table::contains<address, bool>(&v14.upvotes, v0), 9758);
            0x2::linked_table::push_back<address, bool>(&mut v14.upvotes, v0, true);
        } else {
            assert!(arg6 == 2, 9757);
            let v15 = 0x2::linked_table::borrow_mut<address, Dialogue>(&mut 0x1::vector::borrow_mut<BuzzChain>(0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut v12.buzz_chains, arg7), arg8).dialogues, v8);
            assert!(!0x2::linked_table::contains<address, bool>(&v15.upvotes, v0), 9758);
            0x2::linked_table::push_back<address, bool>(&mut v15.upvotes, v0, true);
        };
        let v16 = 0x2::tx_context::epoch(arg9);
        let v17 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg5, arg9);
        manage_new_like(v16, arg2, v17, v9, v8, false, arg9);
        let v18 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_dof_cap, arg3, arg9);
        manage_new_like(v16, arg2, v18, v1, v0, true, arg9);
        0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::chronicle_update_on_engagement(&arg2.hive_entry_cap, arg0, arg1, arg3, 1, arg9);
        let v19 = DialogueUpvoted{
            upvoted_by_username      : v1,
            upvoted_by_profile_addr  : v0,
            poster_username          : v5,
            poster_profile_addr      : v4,
            dialogue_by_username     : v9,
            dialogue_by_profile_addr : v8,
            buzz_type                : arg6,
            buzz_index               : arg7,
            thread_index             : arg8,
        };
        0x2::event::emit<DialogueUpvoted>(v19);
    }

    public entry fun withdraw_flowx_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x69f4b9778665d569a1eb6dc091253b064a3bdddee13594da78582f4fee14d2f::flowx_vampire_attack::withdraw_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** FlowX's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens withdrawn from FlowX lockup of "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" weeks!"));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_WITHDRAWN_FROM_FLOWX"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xe1ec98c4c69be320c77e11196f2e8e19543740505c9b0ab12a10b3c556880a68::lsd_lockdrop::withdraw_from_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6);
        let (_, v1, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"2a2a5355492d68697665535549204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v4, make_num_with_decimals((arg4 as u128), 9));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" SUI withdrawn from SUI-hiveSUI Lockdrop of "));
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v4, 0x1::string::utf8(x"207765656b7321200a20"));
        let v5 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v1, v5, 0x1::string::utf8(b"WITHDRAW_SUI_FROM_LSD_LOCKDROP"), v4, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_kriya_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg4: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x111acdeb4dafee31f2f3a655c67cdb22340490f7291e554cac85a1b61f708402::kriya_vampire_attack::withdraw_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** Kriya's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens withdrawn from Kriya lockup of "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" weeks!"));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_WITHDRAWN_FROM_KRIYA"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_sui_from_infusion<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveManager, arg3: &mut 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x318ca8457c828424ecc0e7bbec2b3d9d8fab830863392e8b249f964f97531d93::infusion::handle_withdraw_sui<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5);
        let (_, v3, _, _) = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(x"2a2a5355492d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg4 as u128), 9));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" SUI withdrawn from SUI-HIVE infusion pool. "));
        let v7 = 0x73eef97bf96ee28f473c4f3db38b296d86a8194599e5b8777982175d16b727b4::hive_profile::entry_borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v7, 0x1::string::utf8(b"WITHDRAW_SUI"), v6, 0x1::option::none<0x1::string::String>());
    }

    // decompiled from Move bytecode v6
}

