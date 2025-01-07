module 0x3d41df95616de4f8b7627b705c516d759bdab31ac7fdb07ef3cb44fac2bc396a::hive_chronicles {
    struct HiveChroniclesVault has key {
        id: 0x2::object::UID,
        hive_entry_cap: 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::HiveEntryCap,
        hive_chronicle_app_cap: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability,
        airdrop_app_cap: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::ManagerAppAccessCapability,
        lockdrop_app_cap: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::ManagerAppAccessCapability,
        infusion_app_cap: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::ManagerAppAccessCapability,
        config_params: ChronicleConfig,
        system_infusion_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, InfusionBuzz>,
        hive_chronicle_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes_list: vector<0x1::string::String>,
        total_bees_available: 0x2::balance::Balance<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>,
        bee_farm_info: BeeFarmInfo,
        is_platform_live: bool,
        bees_farming_snampshots: 0x2::linked_table::LinkedTable<u64, BeesFarmingSnapshot>,
    }

    struct ChronicleConfig has store {
        max_noises: u64,
        max_chronicles: u64,
        max_buzz_chains: u64,
        max_rebuzzes: u64,
        buffer: u64,
    }

    struct BeeFarmInfo has copy, store {
        active_epoch: u64,
        bees_for_epoch: u64,
        entropy_during_epoch: u64,
    }

    struct BeesFarmingSnapshot has copy, store {
        epoch: u64,
        bees_distributed: u64,
        entropy_during_epoch: u64,
        bees_per_entropy: u256,
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

    struct StorageCleanedForChronicle has copy, drop {
        username: 0x1::string::String,
        profile_addr: address,
        noises_deleted: u64,
        chronicles_deleted: u64,
        buzz_chains_deleted: u64,
        rebuzzes_deleted: u64,
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
        rebuzzes: 0x2::linked_table::LinkedTable<u64, ReBuzz>,
        comments_access: u8,
        infusion_buzzes: 0x2::linked_table::LinkedTable<u64, UserInfusionBuzz>,
        infusion_count: u64,
    }

    struct EngagementInfo has store {
        entropy_outbound: u64,
        entropy_inbound: u64,
        bees_farmed: 0x2::linked_table::LinkedTable<u64, u64>,
        bees_to_claim: u64,
    }

    struct ReBuzz has store {
        timestamp: u64,
        buzz_owner_profile: address,
        b_type: u8,
        index: u64,
        inner_index: u64,
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
        dialogues: 0x2::linked_table::LinkedTable<address, Dialogues>,
    }

    struct UserChronicleBuzz has store {
        timestamp: u64,
        asset_id: u64,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, Dialogues>,
    }

    struct BuzzChain has store {
        timestamp: u64,
        narrative: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        appreciations: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, Dialogues>,
    }

    struct Dialogues has store {
        dialogues: 0x2::linked_table::LinkedTable<u64, Dialogue>,
    }

    struct Dialogue has store {
        dialogue: 0x1::string::String,
        upvotes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct BeeFarmDistributionEpochElapsed has copy, drop {
        epoch_over: u64,
        entropy_during_epoch: u64,
        bees_distributed: u64,
        bees_per_entropy: u256,
        bees_burnt: u64,
        next_epoch_bees_for_farming: u64,
    }

    struct BeesFarmedByProfileComputed has copy, drop {
        username: 0x1::string::String,
        profile_addr: address,
        for_epoch: u64,
        entropy_outbound: u64,
        entropy_inbound: u64,
        bees_from_entropy: u64,
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
        dialogue_index: u64,
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
        dialogue_index: u64,
        buzz_type: u8,
        buzz_index: u64,
        thread_index: u64,
    }

    struct NewReBuzz has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        rebuzz_index: u64,
        poster_profile_addr: address,
        buzz_type: u8,
        buzz_index: u64,
        inner_index: u64,
    }

    public entry fun claim_pol_from_streamer_buzz<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::PoolRegistry, arg5: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg6: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg7: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, T1, T2>, arg8: &mut 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::FeeCollector<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::claim_pol_from_streamer_buzz<T0, T1, T2>(arg1, &arg0.hive_entry_cap, &arg0.infusion_app_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v3, v4) = get_buzz_init(arg0, 0x1::string::utf8(b"POL_INFUSED_IN_POOL"));
        let v5 = v3;
        0x1::string::append(&mut v5, 0x1::string::utf8(x"0a0a0a5355492d48495645204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v5, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v5, 0x1::string::utf8(b" LP Tokens"));
        0x1::string::append(&mut v5, 0x1::string::utf8(x"0a0a0a5355492d424545204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v5, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v5, 0x1::string::utf8(b" LP Tokens"));
        0x1::string::append(&mut v5, 0x1::string::utf8(x"0a0a0a5355492d646567656e535549204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
        0x1::string::append(&mut v5, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v5, 0x1::string::utf8(b" LP Tokens"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v5, v4, arg9);
    }

    public entry fun claim_rewards_and_shares_0_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg5: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg7: &0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::BeesManager<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::claim_rewards_and_shares_0_fruits<T0>(&arg0.infusion_app_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9, arg10);
        let (_, v7, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v0, v1, v2, v3, v4, v5);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let (v12, v13) = get_buzz_init(arg0, v11);
        0x1::string::append(&mut v10, v12);
        let v14 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v14, v11, v10, v13);
    }

    public entry fun claim_rewards_and_shares_1_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg5: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg7: &0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::BeesManager<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::claim_rewards_and_shares_1_fruits<T0, T1>(&arg0.infusion_app_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9, arg10);
        let (_, v7, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v0, v1, v2, v3, v4, v5);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let (v12, v13) = get_buzz_init(arg0, v11);
        0x1::string::append(&mut v10, v12);
        let v14 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v14, v11, v10, v13);
    }

    public entry fun claim_rewards_and_shares_2_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg5: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg7: &0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::BeesManager<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::claim_rewards_and_shares_2_fruits<T0, T1, T2>(&arg0.infusion_app_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9, arg10);
        let (_, v7, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v0, v1, v2, v3, v4, v5);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let (v12, v13) = get_buzz_init(arg0, v11);
        0x1::string::append(&mut v10, v12);
        let v14 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v14, v11, v10, v13);
    }

    public entry fun claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg5: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg6: &mut 0x2::token::TokenPolicy<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg7: &0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::BeesManager<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(&arg0.infusion_app_cap, arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg8, arg9, arg10);
        let (_, v7, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v0, v1, v2, v3, v4, v5);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let (v12, v13) = get_buzz_init(arg0, v11);
        0x1::string::append(&mut v10, v12);
        let v14 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v14, v11, v10, v13);
    }

    public entry fun delegate_hive_airdrop<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::delegate_hive_airdrop<T0>(arg1, &arg0.infusion_app_cap, &arg0.airdrop_app_cap, arg2, arg3, arg4, arg5);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let (v8, v9) = get_buzz_init(arg0, 0x1::string::utf8(b"DELEGATE_HIVE_AIRDROP"));
        let v10 = v8;
        0x1::string::append(&mut v10, 0x1::string::utf8(b"+++++++++++++++ "));
        0x1::string::append(&mut v10, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"  HIVE (Airdrop Rewards) --------------->"));
        0x1::string::append(&mut v10, 0x1::string::utf8(b" *BEE* "));
        0x1::string::append(&mut v10, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"  BEE + *HIVE* "));
        0x1::string::append(&mut v10, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"  HIVE"));
        let v11 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v5, v11, 0x1::string::utf8(b"DELEGATE_HIVE_AIRDROP"), v10, v9);
    }

    public entry fun delegate_hive_from_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::delegate_hive_from_lockdrop<T0>(arg0, &arg1.hive_entry_cap, &arg1.infusion_app_cap, arg2, arg3, arg4, arg5, arg6);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"DELEGATE_HIVE_LOCKDROP");
        let (v9, v10) = get_buzz_init(arg1, v8);
        let v11 = v9;
        0x1::string::append(&mut v11, 0x1::string::utf8(b"+++++++++++++++ "));
        0x1::string::append(&mut v11, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v11, 0x1::string::utf8(b"  HIVE (Lockdrop Rewards) --------------->"));
        0x1::string::append(&mut v11, 0x1::string::utf8(b" *BEE* "));
        0x1::string::append(&mut v11, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v11, 0x1::string::utf8(b"  BEE + *HIVE* "));
        0x1::string::append(&mut v11, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v11, 0x1::string::utf8(b"  HIVE"));
        let v12 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v12, v8, v11, v10);
    }

    public entry fun infuse_hive_incentives<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::infuse_hive_incentives<T0>(arg1, &arg0.infusion_app_cap, arg2, arg3, arg4, arg5, arg6);
        let (v0, v1) = get_buzz_init(arg0, 0x1::string::utf8(b"INFUSE_HIVE_INCENTIVES"));
        let v2 = v0;
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b"HIVE tokens have been added as rewards for upcoming Infusion Phase! "));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v2, v1, arg6);
    }

    public entry fun infuse_sui_hive_pool<T0>(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: 0x2::coin::TreasuryCap<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg5: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg6: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg7: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg8: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::PoolRegistry, arg9: &mut 0x43004b3a3ce1e9fc6c54be77e0edac526f5c6c3f7c9ad294fc4c51dddb35d798::three_pool::PoolRegistry, arg10: &mut 0x2::tx_context::TxContext) {
        arg0.is_platform_live = true;
        let (v0, v1, v2, v3, v4, v5) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::infuse_sui_hive_pool<T0>(arg1, &arg0.hive_entry_cap, arg5, arg3, arg2, &arg0.infusion_app_cap, &arg0.airdrop_app_cap, arg4, arg6, arg7, arg8, arg9, arg10);
        let (v6, v7) = get_buzz_init(arg0, 0x1::string::utf8(b"SUI_HIVE_POOL_INFUSED"));
        let v8 = v6;
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a202a5355492d484956452a207c7c20"));
        0x1::string::append(&mut v8, make_num_with_decimals((v0 as u128), 9));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" SUI + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE ===============> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens || *Lock*"));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a0a0a202a5355492d4245452a207c7c20"));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), 9));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" SUI + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v4 as u128), 6));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" BEE ===============> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v5 as u128), 6));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens || *fire* *fire* *fire*"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg5, v8, v7, arg10);
    }

    public entry fun initialize_infusion_vault<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xa9a3ee5899ff8b93b7a1cf5ca8b63169c525a805d20d98bc4af05c05df099c78::dsui_vault::DSuiVault, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfileMappingStore, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::initialize_infusion_vault<T0>(&arg0.infusion_app_cap, arg1, arg4, arg5, arg6, arg7, arg2, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        let (v0, v1) = get_buzz_init(arg0, 0x1::string::utf8(b"INITIALIZE_INFUSION_VAULT"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0, v1, arg16);
    }

    public entry fun stake_lp_tokens_0_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::stake_lp_tokens_0_fruits<T0>(&arg0.infusion_app_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_one_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::stake_lp_tokens_one_fruits<T0, T1>(&arg0.infusion_app_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_three_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::stake_lp_tokens_three_fruits<T0, T1, T2, T3>(&arg0.infusion_app_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_two_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolHive<0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LP<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::stake_lp_tokens_two_fruits<T0, T1, T2>(&arg0.infusion_app_cap, arg1, arg2, arg3, arg4);
    }

    public fun add_app_support_to_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg5: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg6);
        authority_check(v2, v3, 0x2::tx_context::sender(arg8));
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::add_app_support_to_asset(arg4, arg5, arg6, arg7, arg8);
        let v4 = 0x1::string::utf8(b"ADD_APP_TO_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg7 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg6, arg8);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg7, v4, arg2, arg3, true, arg8);
    }

    public entry fun add_entry_to_buzz_chain(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfileMappingStore, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        authority_check(v2, v3, 0x2::tx_context::sender(arg6));
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_kiosks_list_for_creator(arg2, v0);
        assert!(0x1::vector::length<address>(&v4) > 0, 9753);
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg3, arg6);
        let v6 = 0x2::tx_context::epoch(arg6);
        add_to_buzz_chain(v6, 0x2::clock::timestamp_ms(arg0), v1, v5, arg4, arg5, arg6);
    }

    public entry fun add_hive_for_airdrop<T0>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xda950be12a6bc428cb18bcf178701ff27335a0ff371dd5b281bd847eded3509d::airdrop::add_hive_for_airdrop(arg2, &arg1.airdrop_app_cap, arg3, arg5, arg6, arg7);
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"ADD_HIVE_FOR_AIRDROP"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0, v1, arg7);
    }

    public entry fun add_incentives_for_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T1, T2>, arg3: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg4: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg5: u64, arg6: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::add_incentives_for_cetus_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for Cetus DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg3: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg4: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg5: u64, arg6: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::add_incentives_for_flowx_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for FlowX DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg3: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg4: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg5: u64, arg6: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::add_incentives_for_kriya_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for Kriya DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_lsd_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::LsdLockdropVault, arg3: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg4: u64, arg5: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" additional HIVE tokens added as rewards for SUI-degenSUI Lockdrop Pool!"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72205355492d646567656e535549204c6f636b64726f703a20"));
        0x1::string::append(&mut v0, make_num_with_decimals((0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::add_incentives_for_lsd_lockdrop(arg0, arg2, arg3, arg4, arg6) as u128), 6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg5, v0, 0x1::option::none<0x1::string::String>(), arg6);
    }

    public entry fun add_like_to_buzz(arg0: &0x2::clock::Clock, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let (v4, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        assert!(v3 == 0x2::tx_context::sender(arg8), 9751);
        assert!(!v2, 9754);
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg4, arg8);
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
        let v12 = 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_points();
        let v13 = 0x2::tx_context::epoch(arg8);
        manage_entropy_action(v13, arg2, v8, v5, v4, false, v12, true);
        let v14 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg3, arg8);
        manage_entropy_action(v13, arg2, v14, v1, v0, true, v12, true);
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::consume_entropy_of_profile(arg0, &arg2.hive_chronicle_app_cap, arg1, arg3, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_cost(), arg8);
        let v15 = BuzzLiked{
            liked_by_username     : v1,
            poster_username       : v5,
            liked_by_profile_addr : v0,
            poster_profile_addr   : v4,
            buzz_type             : arg5,
            buzz_index            : arg6,
            thread_index          : arg7,
        };
        0x2::event::emit<BuzzLiked>(v15);
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T1, T2, T3>, arg5: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::add_liquidity_to_degenhive<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg6);
        let (v8, v9) = get_buzz_init(arg2, 0x1::string::utf8(b"LIQUIDITY_ADDED_TO_DEGENHIVE"));
        let v10 = v8;
        0x1::string::append(&mut v10, v0);
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v10, make_num_with_decimals((v3 as u128), (v4 as u64)));
        0x1::string::append(&mut v10, 0x1::string::utf8(b" "));
        0x1::string::append(&mut v10, v2);
        0x1::string::append(&mut v10, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v10, make_num_with_decimals((v6 as u128), (v7 as u64)));
        0x1::string::append(&mut v10, 0x1::string::utf8(b" "));
        0x1::string::append(&mut v10, v5);
        0x1::string::append(&mut v10, 0x1::string::utf8(b" -------------------> "));
        0x1::string::append(&mut v10, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a0a20444c5020546f6b656e73207c7c202a4c6f636b2a"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg5, v10, v9, arg6);
    }

    fun add_to_buzz_chain(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut HiveChronicles, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg4) < 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::max_buzz_chain_length(), 9756);
        let v0 = BuzzChain{
            timestamp     : arg1,
            narrative     : arg4,
            gen_ai        : arg5,
            appreciations : 0x2::linked_table::new<address, bool>(arg6),
            dialogues     : 0x2::linked_table::new<address, Dialogues>(arg6),
        };
        let v1 = 0;
        if (0x2::linked_table::contains<u64, vector<BuzzChain>>(&arg3.buzz_chains, arg0)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut arg3.buzz_chains, arg0);
            let v3 = 0x1::vector::length<BuzzChain>(v2);
            v1 = v3;
            assert!(v3 < 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::max_buzz_chain_thread_length(), 9755);
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

    public entry fun add_to_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::add_to_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"2a2a5355492d646567656e5355492a2a200a207c7c20"));
        0x1::string::append(&mut v4, make_num_with_decimals((arg5 as u128), 9));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" SUI || "));
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v4, 0x1::string::utf8(x"207765656b73207c7c202b2b2b2b2b2b2b2b2b200a"));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v1, v5, 0x1::string::utf8(b"ADD_SUI_FOR_LSD_LOCKDROP"), v4, 0x1::option::none<0x1::string::String>());
    }

    public entry fun add_welcome_buzz(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun burn_infusion_tax_collection<T0>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::burn_tax_collection<T0>(arg0, &arg1.infusion_app_cap, arg2, arg3, arg4);
    }

    fun calculate_bees_farmed(arg0: &BeesFarmingSnapshot, arg1: &EngagementInfo) : u64 {
        let v0 = 0;
        if (arg0.bees_per_entropy > 0) {
            v0 = (0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::math::mul_div_u256(((arg1.entropy_outbound + arg1.entropy_inbound) as u256), arg0.bees_per_entropy, (1000000000 as u256)) as u64);
        };
        v0
    }

    fun calculate_bees_per_entropy(arg0: u64, arg1: u64) : u256 {
        if (arg1 > 0) {
            return 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::math::mul_div_u256((arg0 as u256), (1000000000 as u256), (arg1 as u256))
        };
        (arg0 as u256)
    }

    public fun castVote_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveDisperser, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg8);
        authority_check(v2, v3, 0x2::tx_context::sender(arg11));
        let v4 = 0x1::string::utf8(b"MAKE_VOTE_ON_HIVE_DAO_PROPOSAL::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg9 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg8, arg11);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, 0, v4, arg2, arg3, true, arg11);
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::castVote(arg1, arg4, arg5, arg6, arg7, arg9, arg8, arg10, arg11);
    }

    public entry fun claim_bees_for_farming(arg0: &mut HiveChroniclesVault, arg1: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg2: &mut 0x2::token::TokenPolicy<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg3: &0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::BeesManager<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg1);
        authority_check(v2, v3, 0x2::tx_context::sender(arg4));
        let v4 = 0x2::tx_context::epoch(arg4);
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg1, arg4);
        if (v5.active_epoch < v4) {
            let v6 = compute_bees_farmed(arg0, &v5.engagement_metrics, v1, v0, v5.active_epoch);
            0x2::linked_table::push_back<u64, u64>(&mut v5.engagement_metrics.bees_farmed, v5.active_epoch, v6);
            v5.engagement_metrics.bees_to_claim = v5.engagement_metrics.bees_to_claim + v6;
            v5.active_epoch = v4;
            let v7 = &mut v5.engagement_metrics;
            reset_engagement_info(v7);
        };
        if (v5.engagement_metrics.bees_to_claim > 0) {
            let v8 = 0x2::balance::split<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>(&mut arg0.total_bees_available, v5.engagement_metrics.bees_to_claim);
            let v9 = ClaimBeesFromFarming{
                bees_farmed  : 0x2::balance::value<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>(&v8),
                username     : v1,
                profile_addr : v0,
            };
            0x2::event::emit<ClaimBeesFromFarming>(v9);
            0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::transfer_bees_balance(arg2, arg3, v8, 0x2::tx_context::sender(arg4), arg4);
            v5.engagement_metrics.bees_to_claim = 0;
        };
    }

    public entry fun claim_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: u64, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xda950be12a6bc428cb18bcf178701ff27335a0ff371dd5b281bd847eded3509d::airdrop::claim_hive_airdrop(&arg0.airdrop_app_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"CLAIM_AIRDROP");
        let (v5, v6) = get_buzz_init(arg0, v4);
        let v7 = v5;
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a484956452061697264726f70203d"));
        0x1::string::append(&mut v7, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE"));
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v1, v8, v4, v7, v6);
    }

    public entry fun claim_liquidity_from_cetus<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T1, T2>, arg5: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10, v11, v12, v13, v14) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::claim_liquidity_from_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        internal_kraft_cetus_claim_liquidity_stream<T0>(arg2, arg6, arg1, v0, v1, v2, v3, v4, v5, v6, v8, v9, v10, v11, v12, v13, v14, arg7);
    }

    public entry fun claim_liquidity_from_rev_cetus<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T2, T1>, arg5: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10, v11, v12, v13, v14) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::claim_liquidity_from_rev_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        internal_kraft_cetus_claim_liquidity_stream<T0>(arg2, arg6, arg1, v0, v1, v2, v3, v4, v5, v6, v8, v9, v10, v11, v12, v13, v14, arg7);
    }

    public entry fun cleanup_storage_for_chronicle(arg0: &mut HiveChroniclesVault, arg1: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg1);
        let v4 = arg0.config_params.max_noises;
        let v5 = v4;
        let v6 = arg0.config_params.max_chronicles;
        let v7 = v6;
        let v8 = arg0.config_params.max_buzz_chains;
        let v9 = v8;
        let v10 = arg0.config_params.max_rebuzzes;
        let v11 = v10;
        let v12 = arg0.config_params.buffer;
        if (arg3) {
            assert!(v3 == 0x2::tx_context::sender(arg4), 9751);
        } else {
            v5 = v4 + v12;
            v7 = v6 + v12;
            v9 = v8 + v12;
            v11 = v10 + v12;
        };
        let v13 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg2, arg4);
        let v14 = 0x2::linked_table::length<u64, UserNoiseBuzz>(&v13.noise_buzzes);
        let v15 = 0;
        if (v14 > v5) {
            v15 = v14 - v5;
            let v16 = &mut v13.noise_buzzes;
            delete_noises(v16, v5, v14);
        };
        let v17 = 0x2::linked_table::length<u64, UserChronicleBuzz>(&v13.chronicle_buzzes);
        let v18 = 0;
        if (v17 > v7) {
            let v19 = &mut v13.chronicle_buzzes;
            delete_chronicles(v19, v7, v17);
            v18 = v17 - v7;
        };
        let v20 = 0x2::linked_table::length<u64, vector<BuzzChain>>(&v13.buzz_chains);
        let v21 = 0;
        if (v20 > v9) {
            let v22 = &mut v13.buzz_chains;
            delete_buzz_chains(v22, v9, v20);
            v21 = v20 - v9;
        };
        let v23 = 0x2::linked_table::length<u64, ReBuzz>(&v13.rebuzzes);
        let v24 = 0;
        if (v23 > v11) {
            let v25 = &mut v13.rebuzzes;
            delete_rebuzzes(v25, v11, v23);
            v24 = v23 - v11;
        };
        let v26 = StorageCleanedForChronicle{
            username            : v1,
            profile_addr        : v0,
            noises_deleted      : v15,
            chronicles_deleted  : v18,
            buzz_chains_deleted : v21,
            rebuzzes_deleted    : v24,
        };
        0x2::event::emit<StorageCleanedForChronicle>(v26);
    }

    fun compute_bees_farmed(arg0: &HiveChroniclesVault, arg1: &EngagementInfo, arg2: 0x1::string::String, arg3: address, arg4: u64) : u64 {
        let v0 = 0;
        if (0x2::linked_table::contains<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, arg4)) {
            v0 = calculate_bees_farmed(0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, arg4), arg1);
        };
        let v1 = BeesFarmedByProfileComputed{
            username          : arg2,
            profile_addr      : arg3,
            for_epoch         : arg4,
            entropy_outbound  : arg1.entropy_outbound,
            entropy_inbound   : arg1.entropy_inbound,
            bees_from_entropy : v0,
        };
        0x2::event::emit<BeesFarmedByProfileComputed>(v1);
        v0
    }

    fun delete_buzz_chains(arg0: &mut 0x2::linked_table::LinkedTable<u64, vector<BuzzChain>>, arg1: u64, arg2: u64) {
        let v0 = 0;
        while (v0 <= arg2 - arg1) {
            let v1 = *0x2::linked_table::front<u64, vector<BuzzChain>>(arg0);
            let v2 = 0x2::linked_table::remove<u64, vector<BuzzChain>>(arg0, *0x1::option::borrow<u64>(&v1));
            while (!0x1::vector::is_empty<BuzzChain>(&v2)) {
                let BuzzChain {
                    timestamp     : _,
                    narrative     : _,
                    gen_ai        : _,
                    appreciations : v6,
                    dialogues     : v7,
                } = 0x1::vector::pop_back<BuzzChain>(&mut v2);
                0x2::linked_table::drop<address, bool>(v6);
                destroy_dialogues(v7);
            };
            0x1::vector::destroy_empty<BuzzChain>(v2);
            v0 = v0 + 1;
        };
    }

    fun delete_chronicles(arg0: &mut 0x2::linked_table::LinkedTable<u64, UserChronicleBuzz>, arg1: u64, arg2: u64) {
        let v0 = 0;
        while (v0 <= arg2 - arg1) {
            let v1 = *0x2::linked_table::front<u64, UserChronicleBuzz>(arg0);
            let UserChronicleBuzz {
                timestamp : _,
                asset_id  : _,
                move_type : _,
                user_log  : _,
                gen_ai    : _,
                likes     : v7,
                dialogues : v8,
            } = 0x2::linked_table::remove<u64, UserChronicleBuzz>(arg0, *0x1::option::borrow<u64>(&v1));
            0x2::linked_table::drop<address, bool>(v7);
            destroy_dialogues(v8);
            v0 = v0 + 1;
        };
    }

    fun delete_noises(arg0: &mut 0x2::linked_table::LinkedTable<u64, UserNoiseBuzz>, arg1: u64, arg2: u64) {
        let v0 = 0;
        while (v0 <= arg2 - arg1) {
            let v1 = *0x2::linked_table::front<u64, UserNoiseBuzz>(arg0);
            let UserNoiseBuzz {
                timestamp : _,
                epoch     : _,
                noise     : _,
                gen_ai    : _,
                likes     : v6,
                dialogues : v7,
            } = 0x2::linked_table::remove<u64, UserNoiseBuzz>(arg0, *0x1::option::borrow<u64>(&v1));
            0x2::linked_table::drop<address, bool>(v6);
            destroy_dialogues(v7);
            v0 = v0 + 1;
        };
    }

    fun delete_rebuzzes(arg0: &mut 0x2::linked_table::LinkedTable<u64, ReBuzz>, arg1: u64, arg2: u64) {
        let v0 = 0;
        while (v0 <= arg2 - arg1) {
            let v1 = *0x2::linked_table::front<u64, ReBuzz>(arg0);
            let ReBuzz {
                timestamp          : _,
                buzz_owner_profile : _,
                b_type             : _,
                index              : _,
                inner_index        : _,
            } = 0x2::linked_table::remove<u64, ReBuzz>(arg0, *0x1::option::borrow<u64>(&v1));
            v0 = v0 + 1;
        };
    }

    fun destroy_dialogue(arg0: Dialogue) {
        let Dialogue {
            dialogue : _,
            upvotes  : v1,
        } = arg0;
        0x2::linked_table::drop<address, bool>(v1);
    }

    fun destroy_dialogues(arg0: 0x2::linked_table::LinkedTable<address, Dialogues>) {
        while (0 < 0x2::linked_table::length<address, Dialogues>(&arg0)) {
            let (_, v1) = 0x2::linked_table::pop_back<address, Dialogues>(&mut arg0);
            let Dialogues { dialogues: v2 } = v1;
            let v3 = 0;
            while (v3 < 0x2::linked_table::length<u64, Dialogue>(&v2)) {
                let (_, v5) = 0x2::linked_table::pop_back<u64, Dialogue>(&mut v2);
                let Dialogue {
                    dialogue : _,
                    upvotes  : v7,
                } = v5;
                0x2::linked_table::drop<address, bool>(v7);
                v3 = v3 + 1;
            };
            0x2::linked_table::destroy_empty<u64, Dialogue>(v2);
        };
        0x2::linked_table::destroy_empty<address, Dialogues>(arg0);
    }

    public entry fun entry_interact_with_governance_buzz(arg0: &0x2::clock::Clock, arg1: &mut HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::interact_with_governance_buzz(arg0, &arg1.hive_chronicle_app_cap, arg2, arg3, arg4, arg5, arg6, arg7, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_cost(), arg8);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        manage_entropy_action(0x2::tx_context::epoch(arg8), arg1, v4, v1, v0, true, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_points(), false);
    }

    public entry fun entry_interact_with_hive_dao_buzz(arg0: &0x2::clock::Clock, arg1: &mut HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::interact_with_governance_buzz(arg0, &arg1.hive_chronicle_app_cap, arg2, arg3, arg4, arg5, arg6, arg7, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_cost(), arg8);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        manage_entropy_action(0x2::tx_context::epoch(arg8), arg1, v4, v1, v0, true, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_points(), false);
    }

    public entry fun entry_like_governor_buzz(arg0: &0x2::clock::Clock, arg1: &mut HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::like_governor_buzz(arg0, &arg1.hive_chronicle_app_cap, arg2, arg3, arg4, arg5, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_cost(), arg6);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg6);
        manage_entropy_action(0x2::tx_context::epoch(arg6), arg1, v4, v1, v0, true, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_points(), false);
    }

    public entry fun entry_like_hive_dao_buzz(arg0: &0x2::clock::Clock, arg1: &mut HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::like_governor_buzz(arg0, &arg1.hive_chronicle_app_cap, arg2, arg3, arg4, arg5, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_cost(), arg6);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg6);
        manage_entropy_action(0x2::tx_context::epoch(arg6), arg1, v4, v1, v0, true, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_points(), false);
    }

    public entry fun entry_upvote_dialogue_on_buzz(arg0: &0x2::clock::Clock, arg1: &mut HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::PoolsGovernor, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        0x647ee9b7ada055c78537c3b289eb6fa2bfe172365dbf0070be16ff30f5f897f1::dex_dao::upvote_dialogue_on_buzz(arg0, &arg1.hive_chronicle_app_cap, arg2, arg3, arg4, arg5, arg6, arg7, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_cost(), arg8);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        manage_entropy_action(0x2::tx_context::epoch(arg8), arg1, v4, v1, v0, true, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_points(), false);
    }

    public entry fun entry_upvote_dialogue_on_hive_dao_buzz(arg0: &0x2::clock::Clock, arg1: &mut HiveChroniclesVault, arg2: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::upvote_dialogue_on_buzz(arg0, &arg1.hive_chronicle_app_cap, arg2, arg3, arg4, arg5, arg6, arg7, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_cost(), arg8);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        manage_entropy_action(0x2::tx_context::epoch(arg8), arg1, v4, v1, v0, true, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_points(), false);
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::extract_liquidity_from_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let (v11, v12) = get_buzz_init(arg2, 0x1::string::utf8(b"FLOWX_LIQUIDITY_CLAIMED"));
        let v13 = v11;
        0x1::string::append(&mut v13, 0x1::string::utf8(b"*FlowXDEX*"));
        0x1::string::append(&mut v13, v1);
        0x1::string::append(&mut v13, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" LP -----------> "));
        0x1::string::append(&mut v13, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v13, v2);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v13, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v13, v3);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v13, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" HIVE Rewards  || *Lock*"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v13, v12, arg8);
    }

    public entry fun extract_liquidity_from_kriya<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg4: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T2>, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::extract_liquidity_from_kriya<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let (v11, v12) = get_buzz_init(arg2, 0x1::string::utf8(b"KRIYA_LIQUIDITY_CLAIMED"));
        let v13 = v11;
        0x1::string::append(&mut v13, 0x1::string::utf8(b"*KriyaDEX*"));
        0x1::string::append(&mut v13, v1);
        0x1::string::append(&mut v13, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" LP -----------> "));
        0x1::string::append(&mut v13, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v13, v2);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v13, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v13, v3);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v13, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" HIVE Rewards  || *Lock*"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v13, v12, arg8);
    }

    public entry fun extract_liquidity_from_rev_flowx<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T2, T1>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::extract_liquidity_from_rev_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let (v11, v12) = get_buzz_init(arg2, 0x1::string::utf8(b"FLOWX_LIQUIDITY_CLAIMED"));
        let v13 = v11;
        0x1::string::append(&mut v13, 0x1::string::utf8(b"*FlowXDEX*"));
        0x1::string::append(&mut v13, v1);
        0x1::string::append(&mut v13, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" LP -----------> "));
        0x1::string::append(&mut v13, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v13, v2);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v13, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v13, v3);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v13, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" HIVE Rewards  || *Lock*"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v13, v12, arg8);
    }

    public entry fun extract_liquidity_from_rev_kriya<T0, T1, T2, T3>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg4: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T2, T1>, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T1>, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::extract_liquidity_from_rev_kriya<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let (v11, v12) = get_buzz_init(arg2, 0x1::string::utf8(b"KRIYA_LIQUIDITY_CLAIMED"));
        let v13 = v11;
        0x1::string::append(&mut v13, 0x1::string::utf8(b"*KriyaDEX*"));
        0x1::string::append(&mut v13, v1);
        0x1::string::append(&mut v13, make_num_with_decimals((v6 as u128), (v0 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" LP -----------> "));
        0x1::string::append(&mut v13, make_num_with_decimals((v9 as u128), (v4 as u64)));
        0x1::string::append(&mut v13, v2);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v13, make_num_with_decimals((v10 as u128), (v5 as u64)));
        0x1::string::append(&mut v13, v3);
        0x1::string::append(&mut v13, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v13, make_num_with_decimals((v8 as u128), (6 as u64)));
        0x1::string::append(&mut v13, 0x1::string::utf8(b" HIVE Rewards  || *Lock*"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v13, v12, arg8);
    }

    fun get_buzz_init(arg0: &HiveChroniclesVault, arg1: 0x1::string::String) : (0x1::string::String, 0x1::option::Option<0x1::string::String>) {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0x1::option::none<0x1::string::String>();
        if (0x2::linked_table::contains<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, arg1)) {
            let v2 = 0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, arg1);
            0x1::string::append(&mut v0, v2.buzz);
            v1 = v2.gen_ai;
        };
        (v0, v1)
    }

    public fun get_hive_chronicle_for_profile(arg0: &0x2::clock::Clock, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u8, u64, u64) {
        let v0 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_from_profile<HiveChronicles>(arg3, 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_hive_app_name(&arg2.hive_chronicle_app_cap));
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = 0;
        let v3 = 0;
        if (v0.active_epoch < v1 && 0x2::linked_table::contains<u64, BeesFarmingSnapshot>(&arg2.bees_farming_snampshots, v0.active_epoch)) {
            v2 = calculate_bees_farmed(0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg2.bees_farming_snampshots, v0.active_epoch), &v0.engagement_metrics);
        } else if (v0.active_epoch == v1) {
            let v4 = calculate_bees_per_entropy(arg2.bee_farm_info.bees_for_epoch / 2, arg2.bee_farm_info.entropy_during_epoch);
            if (v4 > 0) {
                v3 = (0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::math::mul_div_u256(((v0.engagement_metrics.entropy_inbound + v0.engagement_metrics.entropy_outbound) as u256), v4, (1000000000 as u256)) as u64);
            };
        };
        let v5 = v0.engagement_metrics.bees_to_claim + v2;
        let (v6, v7, v8, v9) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::compute_profile_socialfi_info(arg0, arg1, arg3, arg4);
        (v0.active_epoch, v6, v7, v9, v8, v0.engagement_metrics.entropy_inbound, v0.engagement_metrics.entropy_outbound, v5, v3, 0x2::linked_table::length<u64, ReBuzz>(&v0.rebuzzes), 0x2::linked_table::length<u64, UserNoiseBuzz>(&v0.noise_buzzes), v0.last_noise_epoch, v0.noise_count, 0x2::linked_table::length<u64, UserChronicleBuzz>(&v0.chronicle_buzzes), v0.last_chronicle_epoch, v0.chronicle_count, 0x2::linked_table::length<u64, vector<BuzzChain>>(&v0.buzz_chains), v0.last_buzz_epoch, v0.buzz_count, v0.comments_access, 0x2::linked_table::length<u64, UserInfusionBuzz>(&v0.infusion_buzzes), v0.infusion_count)
    }

    public entry fun increment_bee_farm_epoch(arg0: &mut HiveChroniclesVault, arg1: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::BeesManager<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg2: &mut 0x2::token::TokenPolicy<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > arg0.bee_farm_info.active_epoch) {
            let v1 = 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::claim_bees_for_chronicle_farming(&arg0.hive_entry_cap, arg1, arg3);
            let v2 = 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::bee_trade::burn_bees_from_supply(arg2, arg1, arg3);
            let v3 = calculate_bees_per_entropy(arg0.bee_farm_info.bees_for_epoch, arg0.bee_farm_info.entropy_during_epoch);
            let v4 = BeeFarmDistributionEpochElapsed{
                epoch_over                  : arg0.bee_farm_info.active_epoch,
                entropy_during_epoch        : arg0.bee_farm_info.entropy_during_epoch,
                bees_distributed            : arg0.bee_farm_info.bees_for_epoch,
                bees_per_entropy            : v3,
                bees_burnt                  : v2,
                next_epoch_bees_for_farming : 0x2::balance::value<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>(&v1),
            };
            0x2::event::emit<BeeFarmDistributionEpochElapsed>(v4);
            let v5 = BeesFarmingSnapshot{
                epoch                : arg0.bee_farm_info.active_epoch,
                bees_distributed     : arg0.bee_farm_info.bees_for_epoch,
                entropy_during_epoch : arg0.bee_farm_info.entropy_during_epoch,
                bees_per_entropy     : v3,
                bees_burnt           : v2,
            };
            0x2::linked_table::push_back<u64, BeesFarmingSnapshot>(&mut arg0.bees_farming_snampshots, arg0.bee_farm_info.active_epoch, v5);
            arg0.bee_farm_info.active_epoch = v0;
            arg0.bee_farm_info.bees_for_epoch = 0x2::balance::value<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>(&v1);
            arg0.bee_farm_info.entropy_during_epoch = 0;
            0x2::balance::join<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>(&mut arg0.total_bees_available, v1);
        };
    }

    public fun infuse_gems_into_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveDisperser, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg7);
        authority_check(v2, v3, 0x2::tx_context::sender(arg10));
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::infuse_gems_into_asset(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v4 = 0x1::string::utf8(b"INFUSE_GEMS_INTO_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg9 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg7, arg10);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg9, v4, arg2, arg3, true, arg10);
    }

    public entry fun infuse_sui<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::deposit_sui<T0>(&arg0.infusion_app_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, v3, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let (v6, v7) = get_buzz_init(arg0, 0x1::string::utf8(b"INFUSE_SUI"));
        let v8 = v6;
        0x1::string::append(&mut v8, 0x1::string::utf8(b"+++++++++++++++ "));
        0x1::string::append(&mut v8, make_num_with_decimals((arg5 as u128), 9));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"  SUI  --------------->"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" *BEE* "));
        0x1::string::append(&mut v8, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"  BEE + *HIVE* "));
        0x1::string::append(&mut v8, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"  HIVE"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v9, 0x1::string::utf8(b"INFUSE_SUI"), v8, v7);
    }

    public entry fun infuse_sui_dsui_pool<T0>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropVault, arg4: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<0x2::sui::SUI, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Stable>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xa9a3ee5899ff8b93b7a1cf5ca8b63169c525a805d20d98bc4af05c05df099c78::dsui_vault::DSuiVault, arg7: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg8: &mut 0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::infuse_sui_dsui_pool(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (v4, v5) = get_buzz_init(arg2, 0x1::string::utf8(b"SUI_DEGENSUI_INFUSED"));
        let v6 = v4;
        0x1::string::append(&mut v6, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v6, make_num_with_decimals((v1 as u128), (9 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" SUI + "));
        0x1::string::append(&mut v6, make_num_with_decimals((v0 as u128), (9 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" DSUI -------------->  "));
        0x1::string::append(&mut v6, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" *SUI-degenSUI* DLP Tokens || "));
        0x1::string::append(&mut v6, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v6, v5, arg9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_airdrop_vault<T0>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xda950be12a6bc428cb18bcf178701ff27335a0ff371dd5b281bd847eded3509d::airdrop::initialize_airdrop_vault(arg2, &arg1.airdrop_app_cap, arg5, arg3, arg6, arg7, arg8, arg9);
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"INITIALIZE_AIRDROP_VAULT"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0, v1, arg9);
    }

    public entry fun initialize_attack_on_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg9: u64, arg10: bool, arg11: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a56616d706972652041747461636b206f6e20436574757320444558277320"));
        0x1::string::append(&mut v2, arg6);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" pool."));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204365747573204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_attack_on_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg12)));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204849564520726577617264733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE "));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg11, v2, v1, arg12);
    }

    public entry fun initialize_attack_on_flowx_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: u8, arg7: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg8: u64, arg9: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg10) {
            0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_attack_on_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
        } else {
            0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_attack_on_rev_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
        };
        let (v1, v2) = get_buzz_init(arg1, 0x1::string::utf8(b"FLOWX_ATTACK_INITIALIZED_FOR_POOL"));
        let v3 = v1;
        0x1::string::append(&mut v3, 0x1::string::utf8(x"0a0a56616d706972652041747461636b206f6e20466c6f775820444558277320"));
        0x1::string::append(&mut v3, arg5);
        0x1::string::append(&mut v3, 0x1::string::utf8(b" pool."));
        0x1::string::append(&mut v3, 0x1::string::utf8(x"0a0a20466c6f7758204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v3, 0x2::address::to_string(v0));
        0x1::string::append(&mut v3, 0x1::string::utf8(x"0a0a204849564520726577617264733a20"));
        0x1::string::append(&mut v3, make_num_with_decimals((arg8 as u128), 6));
        0x1::string::append(&mut v3, 0x1::string::utf8(b" HIVE "));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg9, v3, v2, arg11);
    }

    public entry fun initialize_attack_on_kriya_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T1, T2>, arg5: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg9: u64, arg10: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"KRIYA_ATTACK_INITIALIZED_FOR_POOL"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a56616d706972652041747461636b206f6e204b7269796120444558277320"));
        0x1::string::append(&mut v2, arg6);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" pool."));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204b72697961204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_attack_on_kriya_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204849564520726577617264733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE "));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v2, v1, arg11);
    }

    public entry fun initialize_attack_on_rev_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg9: u64, arg10: bool, arg11: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a56616d706972652041747461636b206f6e20436574757320444558277320"));
        0x1::string::append(&mut v2, arg6);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" pool."));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204365747573204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_attack_on_reverse_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg12)));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204849564520726577617264733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE "));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg11, v2, v1, arg12);
    }

    public entry fun initialize_attack_on_rev_kriya_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T1, T2, T3>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T2, T1>, arg5: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg9: u64, arg10: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"KRIYA_ATTACK_INITIALIZED_FOR_POOL"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a56616d706972652041747461636b206f6e204b7269796120444558277320"));
        0x1::string::append(&mut v2, arg6);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" pool."));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204b72697961204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_attack_on_rev_kriya_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a204849564520726577617264733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE "));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v2, v1, arg11);
    }

    public entry fun initialize_hive_chronicles(arg0: 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::HiveEntryCap, arg1: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::ManagerAppAccessCapability, arg3: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::ManagerAppAccessCapability, arg4: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::ManagerAppAccessCapability, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = ChronicleConfig{
            max_noises      : arg5,
            max_chronicles  : arg6,
            max_buzz_chains : arg7,
            max_rebuzzes    : arg8,
            buffer          : arg9,
        };
        let v1 = BeeFarmInfo{
            active_epoch         : 0x2::tx_context::epoch(arg10),
            bees_for_epoch       : 0,
            entropy_during_epoch : 0,
        };
        let v2 = HiveChroniclesVault{
            id                      : 0x2::object::new(arg10),
            hive_entry_cap          : arg0,
            hive_chronicle_app_cap  : arg1,
            airdrop_app_cap         : arg2,
            lockdrop_app_cap        : arg3,
            infusion_app_cap        : arg4,
            config_params           : v0,
            system_infusion_buzzes  : 0x2::linked_table::new<0x1::string::String, InfusionBuzz>(arg10),
            hive_chronicle_buzzes   : 0x2::linked_table::new<0x1::string::String, ChronicleBuzz>(arg10),
            welcome_buzzes          : 0x2::linked_table::new<0x1::string::String, ChronicleBuzz>(arg10),
            welcome_buzzes_list     : 0x1::vector::empty<0x1::string::String>(),
            total_bees_available    : 0x2::balance::zero<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>(),
            bee_farm_info           : v1,
            is_platform_live        : false,
            bees_farming_snampshots : 0x2::linked_table::new<u64, BeesFarmingSnapshot>(arg10),
        };
        0x2::transfer::share_object<HiveChroniclesVault>(v2);
    }

    public entry fun initialize_lockdrop_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xa9a3ee5899ff8b93b7a1cf5ca8b63169c525a805d20d98bc4af05c05df099c78::dsui_vault::DSuiVault, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfileMappingStore, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: u8, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_FOR_POOL"));
        let v2 = v0;
        0x1::string::append(&mut v2, arg11);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool: "));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_lockdrop_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v2, v1, arg18);
    }

    public entry fun initialize_lockdrops<T0>(arg0: &HiveChroniclesVault, arg1: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg2: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg3: 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xa9a3ee5899ff8b93b7a1cf5ca8b63169c525a805d20d98bc4af05c05df099c78::dsui_vault::DSuiVault, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfileMappingStore, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg11: &0x2::clock::Clock, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::initialize_lockdrops(&arg0.hive_entry_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        let (v5, v6) = get_buzz_init(arg0, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_CONFIGs"));
        let v7 = v5;
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a4c6f636b64726f70205661756c7420416464726573733a20"));
        0x1::string::append(&mut v7, 0x2::address::to_string(v0));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a2d20486f6c6473206c6f636b65642053554920616e6420646567656e68697665204c5020746f6b656e73206b72616674656420616761696e7374205355492d646567656e535549206c6f636b64726f70"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a0a4c6f636b64726f7020436f6e6669677320496e697469616c697a65642120"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a4c5344204c6f636b64726f70205661756c743a20"));
        0x1::string::append(&mut v7, 0x2::address::to_string(v1));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a2d20486f6c647320535549206465706f73697465642062792074686520757365727320666f7220626f6f74737472617070696e6720535549202d20646567656e53554920706f6f6c207768656e20746865204c6f636b64726f70207068617365206973206c6976652e"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a4b726979612041747461636b20436f6e6669673a20"));
        0x1::string::append(&mut v7, 0x2::address::to_string(v2));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a2d2053746f72657320636f6e66696775726174696f6e20706172616d657465727320666f722076616d706972652d61747461636b206f6e204b7269796120444558"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a466c6f77582041747461636b20436f6e6669673a20"));
        0x1::string::append(&mut v7, 0x2::address::to_string(v3));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a2d2053746f72657320636f6e66696775726174696f6e20706172616d657465727320666f722076616d706972652d61747461636b206f6e20466c6f775820444558"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a43657475732041747461636b20436f6e6669673a20"));
        0x1::string::append(&mut v7, 0x2::address::to_string(v4));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a2d2053746f72657320636f6e66696775726174696f6e20706172616d657465727320666f722076616d706972652d61747461636b206f6e20436574757320444558"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg11, arg10, v7, v6, arg22);
    }

    public fun initialize_new_app_session_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg5: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveDisperser, arg9: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>, u64, u64) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg6);
        authority_check(v2, v3, 0x2::tx_context::sender(arg11));
        let v4 = 0x1::string::utf8(b"KRAFT_NEW_SKIN_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg10 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg6, arg11);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg10, v4, arg2, arg3, true, arg11);
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::initialize_new_app_session(arg4, arg5, arg1, arg9, arg8, arg6, arg7, arg10, arg11)
    }

    fun internal_kraft_cetus_claim_liquidity_stream<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: u8, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg0, 0x1::string::utf8(b"CETUS_LIQUIDITY_CLAIMED"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(b"*CetusDEX*"));
        0x1::string::append(&mut v2, arg3);
        0x1::string::append(&mut v2, make_num_with_decimals((arg9 as u128), (arg6 as u64)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" LP -----------> "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg10 as u128), (arg7 as u64)));
        0x1::string::append(&mut v2, arg4);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg11 as u128), (arg8 as u64)));
        0x1::string::append(&mut v2, arg5);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg16 as u128), (6 as u64)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE Rewards  || *Lock*"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v2, 0x1::string::utf8(b"Trading fee & rewards earned: "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg12 as u128), (arg7 as u64)));
        0x1::string::append(&mut v2, arg4);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg13 as u128), (arg8 as u64)));
        0x1::string::append(&mut v2, arg5);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg14 as u128), (9 as u64)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" + "));
        0x1::string::append(&mut v2, make_num_with_decimals((arg15 as u128), (9 as u64)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" CETUS"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg2, arg1, v2, v1, arg17);
    }

    public fun kraft_hive_assets_and_return_sui(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xa9a3ee5899ff8b93b7a1cf5ca8b63169c525a805d20d98bc4af05c05df099c78::dsui_vault::DSuiVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg6: 0x1::string::String, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (_, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg7);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::kraft_hive_assets_and_return_sui(&arg0.hive_entry_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v5 = 0x1::string::utf8(b"KRAFT_HIVE_ASSET::");
        0x1::string::append(&mut v5, arg6);
        let (v6, v7) = get_buzz_init(arg0, v5);
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg7, arg10);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v8, 0, v5, v6, v7, false, arg10);
        v4
    }

    public entry fun kraft_hive_profile(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xa9a3ee5899ff8b93b7a1cf5ca8b63169c525a805d20d98bc4af05c05df099c78::dsui_vault::DSuiVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfileMappingStore, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let v1 = kraft_new_hive_chronicle(arg10, v0);
        let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.welcome_buzzes_list, ((0x2::clock::timestamp_ms(arg1) % 0x1::vector::length<0x1::string::String>(&arg0.welcome_buzzes_list)) as u64));
        let v3 = *0x2::linked_table::borrow<0x1::string::String, ChronicleBuzz>(&arg0.welcome_buzzes, v2);
        let v4 = &mut v1;
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), arg8, v4, 0, v2, v3.user_log, v3.gen_ai, false, arg10);
        let v5 = NewChronicleBuzz{
            username  : arg8,
            log_index : 1,
            timestamp : 0x2::clock::timestamp_ms(arg1),
            asset_id  : 0,
            move_type : v2,
            user_log  : v3.user_log,
            gen_ai    : v3.gen_ai,
        };
        0x2::event::emit<NewChronicleBuzz>(v5);
        0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::kraft_hive_profile_and_return_sui<HiveChronicles>(&arg0.hive_entry_cap, &arg0.hive_chronicle_app_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v1, arg10), 0x2::tx_context::sender(arg10), arg10);
    }

    fun kraft_new_hive_chronicle(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : HiveChronicles {
        let v0 = EngagementInfo{
            entropy_outbound : 0,
            entropy_inbound  : 0,
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
            rebuzzes             : 0x2::linked_table::new<u64, ReBuzz>(arg0),
            comments_access      : 0,
            infusion_buzzes      : 0x2::linked_table::new<u64, UserInfusionBuzz>(arg0),
            infusion_count       : 0,
        }
    }

    public entry fun lock_flowx_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::lock_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v3, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"*FlowXDEX*");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v6, make_num_with_decimals((arg6 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP || "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"207765656b73207c7c202b2b2b2b2b2b2b2b2b200a"));
        let v7 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_ADDED_FOR_FLOWX"), v6, 0x1::option::none<0x1::string::String>());
    }

    public fun lock_hive_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveDisperser, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg7);
        authority_check(v2, v3, 0x2::tx_context::sender(arg10));
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::lock_hive_asset(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v4 = 0x1::string::utf8(b"LOCK_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg8 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg7, arg10);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg8, v4, arg2, arg3, true, arg10);
    }

    public entry fun lock_in_x_bee_pool_addr<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg2: &0x2::clock::Clock, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: &mut 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::Config, arg6: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::PoolRegistry, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::FeeCollector<0x2::sui::SUI>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: vector<u64>, arg11: 0x1::option::Option<vector<u256>>, arg12: 0x1::option::Option<vector<u64>>, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg0, 0x1::string::utf8(b"LOCK_IN_BEE_HIVE_POOL_ADDR"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a0a2a5355492d4245452a20506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::lock_in_sui_bee_pool_addr<T0, T1, T2>(arg2, &arg0.hive_entry_cap, &arg0.infusion_app_cap, arg3, arg5, arg6, arg9, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg10, arg11, arg12, arg13)));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg2, arg4, v2, v1, arg13);
    }

    public entry fun lock_in_x_hive_pool_addr<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg2: &0x2::clock::Clock, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: &mut 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::Config, arg6: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::PoolRegistry, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::FeeCollector<0x2::sui::SUI>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: vector<u64>, arg11: 0x1::option::Option<vector<u256>>, arg12: 0x1::option::Option<vector<u64>>, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_buzz_init(arg0, 0x1::string::utf8(b"LOCK_IN_SUI_HIVE_POOL_ADDR"));
        let v2 = v0;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a0a0a2a5355492d484956452a20506f6f6c3a20"));
        0x1::string::append(&mut v2, 0x2::address::to_string(0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::lock_in_sui_hive_pool_addr<T0, T1, T2>(arg2, &arg0.hive_entry_cap, &arg0.infusion_app_cap, arg3, arg5, arg6, arg9, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg10, arg11, arg12, arg13)));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg0.hive_entry_cap, arg2, arg4, v2, v1, arg13);
    }

    public entry fun lock_kriya_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::lock_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v3, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"*KriyaDEX*");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v6, make_num_with_decimals((arg6 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP || "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"207765656b73207c7c202b2b2b2b2b2b2b2b2b200a"));
        let v7 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_DEPOSITED_TO_KRIYA"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun make_a_buzz_fly(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg2);
        authority_check(v2, v3, 0x2::tx_context::sender(arg7));
        let (v4, _, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg3, arg7);
        if (arg4 == 0) {
            assert!(0x2::linked_table::contains<u64, UserNoiseBuzz>(&v8.noise_buzzes, arg5), 9761);
        } else if (arg4 == 1) {
            assert!(0x2::linked_table::contains<u64, UserChronicleBuzz>(&v8.chronicle_buzzes, arg5), 9761);
        } else if (arg4 == 2) {
            assert!(0x2::linked_table::contains<u64, vector<BuzzChain>>(&v8.buzz_chains, arg5), 9761);
            assert!(0x1::vector::length<BuzzChain>(0x2::linked_table::borrow<u64, vector<BuzzChain>>(&v8.buzz_chains, arg5)) > arg6, 9761);
        };
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg2, arg7);
        let v10 = ReBuzz{
            timestamp          : 0x2::clock::timestamp_ms(arg0),
            buzz_owner_profile : v0,
            b_type             : arg4,
            index              : arg5,
            inner_index        : arg6,
        };
        let v11 = 0x2::linked_table::back<u64, ReBuzz>(&v9.rebuzzes);
        let v12 = 0;
        if (0x1::option::is_some<u64>(v11)) {
            v12 = *0x1::option::borrow<u64>(v11);
        };
        0x2::linked_table::push_back<u64, ReBuzz>(&mut v9.rebuzzes, v12 + 1, v10);
        let v13 = NewReBuzz{
            profile_addr        : v0,
            username            : v1,
            rebuzz_index        : v12,
            poster_profile_addr : v4,
            buzz_type           : arg4,
            buzz_index          : arg5,
            inner_index         : arg6,
        };
        0x2::event::emit<NewReBuzz>(v13);
    }

    fun make_buzz_for_infusion_rewards_claim(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"Price Discovery Phase Rewards claimed -::- "));
        if (arg2 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b" *HIVE* + "));
            0x1::string::append(&mut v0, make_num_with_decimals((arg2 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE + "));
        };
        if (arg3 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b" *BEE* + "));
            0x1::string::append(&mut v0, make_num_with_decimals((arg3 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" BEE"));
        };
        if (arg1 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4849564520636c61696d6564206173207374616b696e672072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg1 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE "));
        };
        if (arg5 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5355492d48495645204c5020546f6b656e73206275726e7420617320656d657267656e637920756e6c6f636b20746178202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg5 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens *fire*"));
        };
        v0
    }

    public fun make_listing_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::MarketPlace<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveDisperser, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool, arg17: u8, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg8);
        authority_check(v2, v3, 0x2::tx_context::sender(arg20));
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::make_listing(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        let v4 = 0x1::string::utf8(b"LIST_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg9 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg8, arg20);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg9, v4, arg2, arg3, true, arg20);
    }

    fun make_new_chronicle_log(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            assert!(0x1::string::length(&arg5) < 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::max_chronicle_log_length(), 9746);
        };
        let v0 = 0x2::linked_table::back<u64, UserChronicleBuzz>(&arg2.chronicle_buzzes);
        let v1 = 0;
        if (0x1::option::is_some<u64>(v0)) {
            v1 = *0x1::option::borrow<u64>(v0);
        };
        let v2 = v1 + 1;
        let v3 = UserChronicleBuzz{
            timestamp : arg0,
            asset_id  : arg3,
            move_type : arg4,
            user_log  : arg5,
            gen_ai    : arg6,
            likes     : 0x2::linked_table::new<address, bool>(arg8),
            dialogues : 0x2::linked_table::new<address, Dialogues>(arg8),
        };
        0x2::linked_table::push_back<u64, UserChronicleBuzz>(&mut arg2.chronicle_buzzes, v2, v3);
        if (v2 > 1) {
            let v4 = NewChronicleBuzz{
                username  : arg1,
                log_index : v2,
                timestamp : arg0,
                asset_id  : arg3,
                move_type : arg4,
                user_log  : arg5,
                gen_ai    : arg6,
            };
            0x2::event::emit<NewChronicleBuzz>(v4);
        };
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
        assert!(0x1::string::length(&arg4) < 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::max_noise_length(), 9747);
        if (arg0 == arg3.last_noise_epoch) {
            arg3.noise_count = arg3.noise_count + 1;
            assert!(arg3.noise_count < 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::max_noise_per_epoch(), 9748);
        } else {
            arg3.last_noise_epoch = arg0;
            arg3.noise_count = 1;
        };
        let v0 = 0x2::linked_table::back<u64, UserNoiseBuzz>(&arg3.noise_buzzes);
        let v1 = 0;
        if (0x1::option::is_some<u64>(v0)) {
            v1 = *0x1::option::borrow<u64>(v0);
        };
        let v2 = v1 + 1;
        let v3 = UserNoiseBuzz{
            timestamp : arg1,
            epoch     : arg0,
            noise     : arg4,
            gen_ai    : arg5,
            likes     : 0x2::linked_table::new<address, bool>(arg6),
            dialogues : 0x2::linked_table::new<address, Dialogues>(arg6),
        };
        0x2::linked_table::push_back<u64, UserNoiseBuzz>(&mut arg3.noise_buzzes, v2, v3);
        let v4 = NewNoiseBuzz{
            username    : arg2,
            noise_index : v2,
            timestamp   : arg1,
            epoch       : arg0,
            noise       : arg4,
            gen_ai      : arg5,
        };
        0x2::event::emit<NewNoiseBuzz>(v4);
    }

    fun make_num_with_decimals(arg0: u128, arg1: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::math::pow(10, (arg1 as u128));
        let v1 = 0x1::string::utf8(u64_to_ascii(((arg0 / v0) as u64)));
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v1, 0x1::string::utf8(u64_to_ascii(((arg0 % v0) as u64))));
        v1
    }

    public entry fun make_some_noise(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg2);
        authority_check(v2, v3, 0x2::tx_context::sender(arg5));
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg2, arg5);
        let v5 = 0x2::tx_context::epoch(arg5);
        make_new_noise(v5, 0x2::clock::timestamp_ms(arg0), v1, v4, arg3, arg4, arg5);
    }

    fun manage_entropy_action(arg0: u64, arg1: &mut HiveChroniclesVault, arg2: &mut HiveChronicles, arg3: 0x1::string::String, arg4: address, arg5: bool, arg6: u64, arg7: bool) {
        assert!(!arg1.is_platform_live || arg0 == arg1.bee_farm_info.active_epoch, 9749);
        if (arg7) {
            arg1.bee_farm_info.entropy_during_epoch = arg1.bee_farm_info.entropy_during_epoch + arg6 * 2;
        } else {
            arg1.bee_farm_info.entropy_during_epoch = arg1.bee_farm_info.entropy_during_epoch + arg6;
        };
        if (arg2.active_epoch < arg0) {
            let v0 = compute_bees_farmed(arg1, &arg2.engagement_metrics, arg3, arg4, arg2.active_epoch);
            0x2::linked_table::push_back<u64, u64>(&mut arg2.engagement_metrics.bees_farmed, arg2.active_epoch, v0);
            arg2.engagement_metrics.bees_to_claim = arg2.engagement_metrics.bees_to_claim + v0;
            arg2.active_epoch = arg0;
            let v1 = &mut arg2.engagement_metrics;
            reset_engagement_info(v1);
        };
        if (arg5) {
            arg2.engagement_metrics.entropy_outbound = arg2.engagement_metrics.entropy_outbound + arg6;
        } else {
            arg2.engagement_metrics.entropy_inbound = arg2.engagement_metrics.entropy_inbound + arg6;
        };
    }

    public entry fun migrate_user_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T0, T1, T2>, arg7: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg8: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T0, T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_cetus_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"Congratulations! Cetus NFT positions for ");
        0x1::string::append(&mut v8, v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v8, make_num_with_decimals((v0 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" cetus liquidity ---------> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v9, 0x1::string::utf8(b"CETUS_POSITION_MIGRATED"), v8, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T0, T1, T2>, arg7: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg8: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_flowx_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"Congratulations! Locked FlowX LP positions for ");
        0x1::string::append(&mut v8, v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v8, make_num_with_decimals(v0, (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" FlowX LP ---------> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v9, 0x1::string::utf8(b"FLOWX_POSITION_MIGRATED"), v8, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_kriya_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T0, T1, T2>, arg7: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg8: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_kriya_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"Congratulations! Locked Kriya LP positions for ");
        0x1::string::append(&mut v8, v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v8, make_num_with_decimals((v0 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" Kriya LP ---------> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v9, 0x1::string::utf8(b"KRIYA_POSITION_MIGRATED"), v8, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T0, T1, T2>, arg7: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg8: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T1, T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_rev_cetus_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"Congratulations! Locked Cetus NFT positions for ");
        0x1::string::append(&mut v8, v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v8, make_num_with_decimals((v0 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" cetus liquidity ---------> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v9, 0x1::string::utf8(b"CETUS_POSITION_MIGRATED"), v8, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T0, T1, T2>, arg7: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg8: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_rev_flowx_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"Congratulations! Locked FlowX LP positions for ");
        0x1::string::append(&mut v8, v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v8, make_num_with_decimals(v0, (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" FlowX LP ---------> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v9, 0x1::string::utf8(b"FLOWX_POSITION_MIGRATED"), v8, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_kriya_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropForPool<T0, T1, T2>, arg7: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg8: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T1, T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_rev_kriya_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v8 = 0x1::string::utf8(b"Congratulations! Locked Kriya LP positions for ");
        0x1::string::append(&mut v8, v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v8, make_num_with_decimals((v0 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" Kriya LP ---------> "));
        0x1::string::append(&mut v8, make_num_with_decimals((v3 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" DLP Tokens + "));
        0x1::string::append(&mut v8, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v8, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v9 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v5, v9, 0x1::string::utf8(b"KRIYA_POSITION_MIGRATED"), v8, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_sui_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg6: &mut 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::LockdropVault, arg7: &mut 0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::LsdLockdropVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x6a0d03e255f2218081868ad0d806874f972ed2b71a47d368291a72d56f4e3ff7::lockdrop::migrate_user_sui_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v4, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(x"436f6e67726174756c6174696f6e7321205355492d646567656e535549206c6f636b757020706f736974696f6e73207375636365737366756c6c792066696e616c697a656421200a0a207c7c20");
        0x1::string::append(&mut v7, make_num_with_decimals((v0 as u128), (9 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" SUI ---------> "));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"*SUI-degenSUI* DLP Tokens + "));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE Rewards || *Lock*"));
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"SUI_HIVE_SUI_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun new_add_system_buzz(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun new_test_infuse_sui_hive_pool<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x2::coin::TreasuryCap<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE>, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>, arg8: u64, arg9: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg10: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::LiquidityPool<T0, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::bee::BEE, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves::Curved>, arg11: &mut 0x9696aec81b56286f0ffaf986467c819ff1d10540ba2ff696ba8aaee976b7a0ab::two_pool::PoolRegistry, arg12: &mut 0x43004b3a3ce1e9fc6c54be77e0edac526f5c6c3f7c9ad294fc4c51dddb35d798::three_pool::PoolRegistry, arg13: &mut 0x2::tx_context::TxContext) {
        0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::testnet_infuse_sui_hive_pool<T0>(arg1, &arg0.hive_entry_cap, arg4, arg3, arg2, &mut arg5, arg6, &mut arg7, arg8, &arg0.infusion_app_cap, arg9, arg10, arg11, arg12, arg13);
        0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::coin_helper::destroy_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg5), 0x2::tx_context::sender(arg13), arg13);
        0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::coin_helper::destroy_or_transfer_balance<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>(0x2::coin::into_balance<0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HIVE>(arg7), 0x2::tx_context::sender(arg13), arg13);
    }

    public fun port_gems_to_app_via_asset_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::HiveDaoGovernor, arg5: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg6: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg7: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg8: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::DSuiDisperser<0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::dsui::DSUI>, arg9: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveDisperser, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::hive_gems::HiveGems {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg6);
        authority_check(v2, v3, 0x2::tx_context::sender(arg12));
        let v4 = 0x1::string::utf8(b"PORT_GEMS_FOR_SKIN_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg10 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg6, arg12);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg10, v4, arg2, arg3, true, arg12);
        0xc30ad2aa9f98a6c5adf643502fbb066fa78b08ed91ab148b38a34d260ac346ab::hive_dao::port_gems_to_app_via_asset(arg1, arg4, arg5, arg7, arg8, arg9, arg6, arg10, arg11, arg12)
    }

    public fun query_across_likes(arg0: &HiveChroniclesVault, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg2: bool, arg3: u64, arg4: 0x1::option::Option<address>, arg5: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = if (arg2) {
            let v2 = 0x2::linked_table::borrow<u64, UserNoiseBuzz>(&0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_from_profile<HiveChronicles>(arg1, 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_hive_app_name(&arg0.hive_chronicle_app_cap)).noise_buzzes, arg3);
            let v3 = if (0x1::option::is_some<address>(&arg4)) {
                arg4
            } else {
                *0x2::linked_table::front<address, bool>(&v2.likes)
            };
            let v4 = v3;
            let v5 = 0;
            while (0x1::option::is_some<address>(&v4) && v5 < arg5) {
                let v6 = *0x1::option::borrow<address>(&v4);
                0x1::vector::push_back<address>(&mut v0, v6);
                v4 = *0x2::linked_table::next<address, bool>(&v2.likes, v6);
                v5 = v5 + 1;
            };
            0x2::linked_table::length<address, bool>(&v2.likes)
        } else {
            let v7 = 0x2::linked_table::borrow<u64, UserChronicleBuzz>(&0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_from_profile<HiveChronicles>(arg1, 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_hive_app_name(&arg0.hive_chronicle_app_cap)).chronicle_buzzes, arg3);
            let v8 = if (0x1::option::is_some<address>(&arg4)) {
                arg4
            } else {
                *0x2::linked_table::front<address, bool>(&v7.likes)
            };
            let v9 = v8;
            let v10 = 0;
            while (0x1::option::is_some<address>(&v9) && v10 < arg5) {
                let v11 = *0x1::option::borrow<address>(&v9);
                0x1::vector::push_back<address>(&mut v0, v11);
                v9 = *0x2::linked_table::next<address, bool>(&v7.likes, v11);
                v10 = v10 + 1;
            };
            0x2::linked_table::length<address, bool>(&v7.likes)
        };
        (v0, v1)
    }

    public fun query_across_likes_for_buzz_chain(arg0: &HiveChroniclesVault, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: 0x1::option::Option<address>, arg5: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::borrow<BuzzChain>(0x2::linked_table::borrow<u64, vector<BuzzChain>>(&0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_from_profile<HiveChronicles>(arg1, 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_hive_app_name(&arg0.hive_chronicle_app_cap)).buzz_chains, arg2), arg3);
        let v2 = if (0x1::option::is_some<address>(&arg4)) {
            arg4
        } else {
            *0x2::linked_table::front<address, bool>(&v1.appreciations)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg5) {
            let v5 = *0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, v5);
            v3 = *0x2::linked_table::next<address, bool>(&v1.appreciations, v5);
            v4 = v4 + 1;
        };
        (v0, 0x2::linked_table::length<address, bool>(&v1.appreciations))
    }

    public fun query_bees_farmed_for_profile(arg0: &HiveChroniclesVault, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg2: u64, arg3: u64) : (vector<u64>, vector<u64>) {
        let v0 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_from_profile<HiveChronicles>(arg1, 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_hive_app_name(&arg0.hive_chronicle_app_cap));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = if (arg2 > 0) {
            0x1::option::some<u64>(arg2)
        } else {
            *0x2::linked_table::front<u64, u64>(&v0.engagement_metrics.bees_farmed)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<u64>(&v4) && v5 < arg3) {
            let v6 = *0x1::option::borrow<u64>(&v4);
            0x1::vector::push_back<u64>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, *0x2::linked_table::borrow<u64, u64>(&v0.engagement_metrics.bees_farmed, v6));
            v4 = *0x2::linked_table::next<u64, u64>(&v0.engagement_metrics.bees_farmed, v6);
            v5 = v5 + 1;
        };
        (v1, v2)
    }

    public fun query_bees_farming_snampshot(arg0: &HiveChroniclesVault, arg1: u64) : (u64, u64, u64, u256, u64) {
        let v0 = 0x2::linked_table::borrow<u64, BeesFarmingSnapshot>(&arg0.bees_farming_snampshots, arg1);
        (v0.epoch, v0.bees_distributed, v0.entropy_during_epoch, v0.bees_per_entropy, v0.bees_burnt)
    }

    fun reset_engagement_info(arg0: &mut EngagementInfo) {
        arg0.entropy_outbound = 0;
        arg0.entropy_inbound = 0;
    }

    public entry fun stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T0, T1>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::stake_cetus_position<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"*CETUS*");
        0x1::string::append(&mut v7, v1);
        0x1::string::append(&mut v7, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v7, make_num_with_decimals((v0 as u128), (v2 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP || "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(arg9)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"207765656b73207c7c202b2b2b2b2b2b2b2b2b200a"));
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"LP_DEPOSITED_FOR_CETUS"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun stake_rev_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::CetusLockdropForPool<T0, T1>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd7cee3a2a26cfeb71f371b17d163ec42ea6bcbe02e424c61ee52d1335d59ebc1::cetus_vampire_attack::stake_rev_cetus_position<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"*CETUS*");
        0x1::string::append(&mut v7, v1);
        0x1::string::append(&mut v7, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v7, make_num_with_decimals((v0 as u128), (v2 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP || "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(arg9)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"207765656b73207c7c202b2b2b2b2b2b2b2b2b200a"));
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"LP_DEPOSITED_FOR_CETUS"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun transfer_unclaimed_hive<T0>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: &mut 0x2::tx_context::TxContext) {
        0xda950be12a6bc428cb18bcf178701ff27335a0ff371dd5b281bd847eded3509d::airdrop::transfer_unclaimed_hive(&arg1.airdrop_app_cap, arg2, arg3, arg4, arg5);
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"HIVE_AIRDROP_COMPLETE"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0, v1, arg5);
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

    public entry fun update_airdrop_vault<T0>(arg0: &0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::config::DegenHiveDeployerCap, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg4: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xda950be12a6bc428cb18bcf178701ff27335a0ff371dd5b281bd847eded3509d::airdrop::update_airdrop_vault(&arg1.airdrop_app_cap, arg3, arg5, arg6, arg7);
        let (v0, v1) = get_buzz_init(arg1, 0x1::string::utf8(b"HIVE_AIRDROP_VAULT_UPDATED"));
        0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::make_hive_launch_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0, v1, arg7);
    }

    public fun update_app_config_with_noise(arg0: &mut HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveAppAccessCapability, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: bool, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg5);
        authority_check(v2, v3, 0x2::tx_context::sender(arg13));
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::update_app_config(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v4 = 0x1::string::utf8(b"UPDATE_CONFIG_FOR_APP_FOR_HIVE_ASSET::");
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii((arg6 as u64))));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg5, arg13);
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), v1, v5, arg6, v4, arg2, arg3, true, arg13);
    }

    public entry fun update_dialogue_to_buzz(arg0: &0x2::clock::Clock, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let (v4, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        assert!(v3 == 0x2::tx_context::sender(arg11), 9751);
        let (v8, _, v10, _, _, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_access_to_hive_info(arg0, arg3, v4);
        let v15 = v10;
        if (!v8) {
            v15 = 0;
        };
        let v16 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg4, arg11);
        assert!(v15 >= v16.comments_access, 9760);
        if (arg5 == 0) {
            let v17 = 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v16.noise_buzzes, arg6);
            if (!arg10 && !0x2::linked_table::contains<address, Dialogues>(&v17.dialogues, v0)) {
                let v18 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg11)};
                let v19 = Dialogue{
                    dialogue : arg9,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg11),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v18.dialogues, 0, v19);
                0x2::linked_table::push_back<address, Dialogues>(&mut v17.dialogues, v0, v18);
            } else if (!arg10) {
                let v20 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v17.dialogues, v0);
                if (0x2::linked_table::contains<u64, Dialogue>(&v20.dialogues, arg8)) {
                    0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v20.dialogues, arg8).dialogue = arg9;
                } else {
                    let v21 = Dialogue{
                        dialogue : arg9,
                        upvotes  : 0x2::linked_table::new<address, bool>(arg11),
                    };
                    0x2::linked_table::push_back<u64, Dialogue>(&mut v20.dialogues, arg8, v21);
                };
            } else {
                destroy_dialogue(0x2::linked_table::remove<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v17.dialogues, v0).dialogues, arg8));
            };
        } else if (arg5 == 1) {
            let v22 = 0x2::linked_table::borrow_mut<u64, UserChronicleBuzz>(&mut v16.chronicle_buzzes, arg6);
            if (!arg10 && !0x2::linked_table::contains<address, Dialogues>(&v22.dialogues, v0)) {
                let v23 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg11)};
                let v24 = Dialogue{
                    dialogue : arg9,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg11),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v23.dialogues, 0, v24);
                0x2::linked_table::push_back<address, Dialogues>(&mut v22.dialogues, v0, v23);
            } else if (!arg10) {
                let v25 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v22.dialogues, v0);
                if (0x2::linked_table::contains<u64, Dialogue>(&v25.dialogues, arg8)) {
                    0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v25.dialogues, arg8).dialogue = arg9;
                } else {
                    let v26 = Dialogue{
                        dialogue : arg9,
                        upvotes  : 0x2::linked_table::new<address, bool>(arg11),
                    };
                    0x2::linked_table::push_back<u64, Dialogue>(&mut v25.dialogues, arg8, v26);
                };
            } else {
                destroy_dialogue(0x2::linked_table::remove<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v22.dialogues, v0).dialogues, arg8));
            };
        } else {
            assert!(arg5 == 2, 9757);
            let v27 = 0x1::vector::borrow_mut<BuzzChain>(0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut v16.buzz_chains, arg6), arg7);
            if (!arg10 && !0x2::linked_table::contains<address, Dialogues>(&v27.dialogues, v0)) {
                let v28 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg11)};
                let v29 = Dialogue{
                    dialogue : arg9,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg11),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v28.dialogues, 0, v29);
                0x2::linked_table::push_back<address, Dialogues>(&mut v27.dialogues, v0, v28);
            } else if (!arg10) {
                let v30 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v27.dialogues, v0);
                if (0x2::linked_table::contains<u64, Dialogue>(&v30.dialogues, arg8)) {
                    0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v30.dialogues, arg8).dialogue = arg9;
                } else {
                    let v31 = Dialogue{
                        dialogue : arg9,
                        upvotes  : 0x2::linked_table::new<address, bool>(arg11),
                    };
                    0x2::linked_table::push_back<u64, Dialogue>(&mut v30.dialogues, arg8, v31);
                };
            } else {
                destroy_dialogue(0x2::linked_table::remove<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v27.dialogues, v0).dialogues, arg8));
            };
        };
        let v32 = 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_points();
        let v33 = 0x2::tx_context::epoch(arg11);
        manage_entropy_action(v33, arg2, v16, v5, v4, false, v32, true);
        let v34 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg3, arg11);
        manage_entropy_action(v33, arg2, v34, v1, v0, true, v32, true);
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::consume_entropy_of_profile(arg0, &arg2.hive_chronicle_app_cap, arg1, arg3, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_cost(), arg11);
        let v35 = DialogueAdded{
            by_username         : v1,
            by_profile_addr     : v0,
            poster_username     : v5,
            poster_profile_addr : v4,
            buzz_type           : arg5,
            buzz_index          : arg6,
            thread_index        : arg7,
            dialogue_index      : arg8,
            dialogue            : arg9,
            to_remove           : arg10,
        };
        0x2::event::emit<DialogueAdded>(v35);
    }

    public entry fun update_dialogue_to_own_buzz(arg0: &0x2::clock::Clock, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        assert!(v3 == 0x2::tx_context::sender(arg10), 9751);
        let v4 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg3, arg10);
        if (arg4 == 0) {
            let v5 = 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v4.noise_buzzes, arg5);
            if (!arg9 && !0x2::linked_table::contains<address, Dialogues>(&v5.dialogues, v0)) {
                let v6 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg10)};
                let v7 = Dialogue{
                    dialogue : arg8,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v6.dialogues, 0, v7);
                0x2::linked_table::push_back<address, Dialogues>(&mut v5.dialogues, v0, v6);
            } else if (!arg9) {
                let v8 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v5.dialogues, v0);
                if (0x2::linked_table::contains<u64, Dialogue>(&v8.dialogues, arg7)) {
                    0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v8.dialogues, arg7).dialogue = arg8;
                } else {
                    let v9 = Dialogue{
                        dialogue : arg8,
                        upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                    };
                    0x2::linked_table::push_back<u64, Dialogue>(&mut v8.dialogues, arg7, v9);
                };
            } else {
                destroy_dialogue(0x2::linked_table::remove<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v5.dialogues, v0).dialogues, arg7));
            };
        } else if (arg4 == 1) {
            let v10 = 0x2::linked_table::borrow_mut<u64, UserChronicleBuzz>(&mut v4.chronicle_buzzes, arg5);
            if (!arg9 && !0x2::linked_table::contains<address, Dialogues>(&v10.dialogues, v0)) {
                let v11 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg10)};
                let v12 = Dialogue{
                    dialogue : arg8,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v11.dialogues, 0, v12);
                0x2::linked_table::push_back<address, Dialogues>(&mut v10.dialogues, v0, v11);
            } else if (!arg9) {
                let v13 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v10.dialogues, v0);
                if (0x2::linked_table::contains<u64, Dialogue>(&v13.dialogues, arg7)) {
                    0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v13.dialogues, arg7).dialogue = arg8;
                } else {
                    let v14 = Dialogue{
                        dialogue : arg8,
                        upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                    };
                    0x2::linked_table::push_back<u64, Dialogue>(&mut v13.dialogues, arg7, v14);
                };
            } else {
                destroy_dialogue(0x2::linked_table::remove<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v10.dialogues, v0).dialogues, arg7));
            };
        } else {
            assert!(arg4 == 2, 9757);
            let v15 = 0x1::vector::borrow_mut<BuzzChain>(0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut v4.buzz_chains, arg5), arg6);
            if (!arg9 && !0x2::linked_table::contains<address, Dialogues>(&v15.dialogues, v0)) {
                let v16 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg10)};
                let v17 = Dialogue{
                    dialogue : arg8,
                    upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v16.dialogues, 0, v17);
                0x2::linked_table::push_back<address, Dialogues>(&mut v15.dialogues, v0, v16);
            } else if (!arg9) {
                let v18 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v15.dialogues, v0);
                if (0x2::linked_table::contains<u64, Dialogue>(&v18.dialogues, arg7)) {
                    0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v18.dialogues, arg7).dialogue = arg8;
                } else {
                    let v19 = Dialogue{
                        dialogue : arg8,
                        upvotes  : 0x2::linked_table::new<address, bool>(arg10),
                    };
                    0x2::linked_table::push_back<u64, Dialogue>(&mut v18.dialogues, arg7, v19);
                };
            } else {
                destroy_dialogue(0x2::linked_table::remove<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v15.dialogues, v0).dialogues, arg7));
            };
        };
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::consume_entropy_of_profile(arg0, &arg2.hive_chronicle_app_cap, arg1, arg3, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_comment_entropy_points(), arg10);
        let v20 = DialogueAdded{
            by_username         : v1,
            by_profile_addr     : v0,
            poster_username     : v1,
            poster_profile_addr : v0,
            buzz_type           : arg4,
            buzz_index          : arg5,
            thread_index        : arg6,
            dialogue_index      : arg7,
            dialogue            : arg8,
            to_remove           : arg9,
        };
        0x2::event::emit<DialogueAdded>(v20);
    }

    public entry fun upvote_dialogue_to_buzz(arg0: &0x2::clock::Clock, arg1: &0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg2: &mut HiveChroniclesVault, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let (v4, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let (v8, v9, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg5);
        assert!(v3 == 0x2::tx_context::sender(arg10), 9751);
        let v12 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg4, arg10);
        if (arg7 == 0) {
            let v13 = 0x2::linked_table::borrow_mut<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut 0x2::linked_table::borrow_mut<u64, UserNoiseBuzz>(&mut v12.noise_buzzes, arg8).dialogues, v8).dialogues, arg6);
            assert!(!0x2::linked_table::contains<address, bool>(&v13.upvotes, v0), 9758);
            0x2::linked_table::push_back<address, bool>(&mut v13.upvotes, v0, true);
        } else if (arg7 == 1) {
            let v14 = 0x2::linked_table::borrow_mut<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut 0x2::linked_table::borrow_mut<u64, UserChronicleBuzz>(&mut v12.chronicle_buzzes, arg8).dialogues, v8).dialogues, arg6);
            assert!(!0x2::linked_table::contains<address, bool>(&v14.upvotes, v0), 9758);
            0x2::linked_table::push_back<address, bool>(&mut v14.upvotes, v0, true);
        } else {
            assert!(arg7 == 2, 9757);
            let v15 = 0x2::linked_table::borrow_mut<u64, Dialogue>(&mut 0x2::linked_table::borrow_mut<address, Dialogues>(&mut 0x1::vector::borrow_mut<BuzzChain>(0x2::linked_table::borrow_mut<u64, vector<BuzzChain>>(&mut v12.buzz_chains, arg8), arg9).dialogues, v8).dialogues, arg6);
            assert!(!0x2::linked_table::contains<address, bool>(&v15.upvotes, v0), 9758);
            0x2::linked_table::push_back<address, bool>(&mut v15.upvotes, v0, true);
        };
        let v16 = 0x2::tx_context::epoch(arg10);
        let v17 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg5, arg10);
        let v18 = 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_points();
        manage_entropy_action(v16, arg2, v17, v9, v8, false, v18, true);
        let v19 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg2.hive_chronicle_app_cap, arg3, arg10);
        manage_entropy_action(v16, arg2, v19, v1, v0, true, v18, true);
        0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::consume_entropy_of_profile(arg0, &arg2.hive_chronicle_app_cap, arg1, arg3, 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::constants::chronicle_like_entropy_cost(), arg10);
        let v20 = DialogueUpvoted{
            upvoted_by_username      : v1,
            upvoted_by_profile_addr  : v0,
            poster_username          : v5,
            poster_profile_addr      : v4,
            dialogue_by_username     : v9,
            dialogue_by_profile_addr : v8,
            dialogue_index           : arg6,
            buzz_type                : arg7,
            buzz_index               : arg8,
            thread_index             : arg9,
        };
        0x2::event::emit<DialogueUpvoted>(v20);
    }

    public entry fun withdraw_flowx_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4067c3fe0ed6f477e1e8742ead695e987d139e5e41256663e48f2ba05c63a79::flowx_vampire_attack::withdraw_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v3, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"*FlowXDEX*");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP || "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"207765656b73207c7c202d2d2d2d2d2d2d2d2d200a"));
        let v7 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_WITHDRAWN_FROM_FLOWX"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x687b312b21e1ba0a5221c58bd14a52624f61e65aaa630d82f5202fb7e31696cb::lsd_lockdrop::withdraw_from_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6);
        let (_, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"2a5355492d646567656e5355492a200a207c7c20"));
        0x1::string::append(&mut v4, make_num_with_decimals((arg4 as u128), 9));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" SUI || "));
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v4, 0x1::string::utf8(x"207765656b73207c7c202d2d2d2d2d2d2d2d2d200a"));
        let v5 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v1, v5, 0x1::string::utf8(b"WITHDRAW_SUI_FROM_LSD_LOCKDROP"), v4, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0x6b3c8814981b2205b795e8ef89a3220f8271752881c5c90d57436193181435f0::hive::HiveVault, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v4 = 0x1::string::utf8(b"WITHDRAW_AIRDROP");
        let (v5, v6) = get_buzz_init(arg0, v4);
        let v7 = v5;
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a484956452077697468647261776e203d"));
        0x1::string::append(&mut v7, make_num_with_decimals((0xda950be12a6bc428cb18bcf178701ff27335a0ff371dd5b281bd847eded3509d::airdrop::withdraw_hive_airdrop(&arg0.airdrop_app_cap, arg2, arg3, arg4, arg5) as u128), 6));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE"));
        let v8 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg4, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v1, v8, v4, v7, v6);
    }

    public entry fun withdraw_kriya_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg4: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4a1a68bf5c288a8d64764e47af909f6d46cc539a0356cd2a1cc58547f02e168d::kriya_vampire_attack::withdraw_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v3, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"*KriyaDEX*");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(b" || "));
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP || "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"207765656b73207c7c202d2d2d2d2d2d2d2d2d200a"));
        let v7 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg1.hive_chronicle_app_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_WITHDRAWN_FROM_KRIYA"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_sui_from_infusion<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveManager, arg3: &mut 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _) = 0x1fe61a72fb2bc57bc1104234bd6b656c4d4606e5d6098b794f180d6dc530b99a::infusion::handle_withdraw_sui<T0>(&arg0.infusion_app_cap, arg1, arg2, arg3, arg4, arg5);
        let (_, v5, _, _) = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::get_profile_meta_info(arg3);
        let (v8, v9) = get_buzz_init(arg0, 0x1::string::utf8(b"WITHDRAW_SUI"));
        let v10 = v8;
        0x1::string::append(&mut v10, 0x1::string::utf8(b"--------------- "));
        0x1::string::append(&mut v10, make_num_with_decimals((arg4 as u128), 9));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"  SUI  --------------->"));
        0x1::string::append(&mut v10, 0x1::string::utf8(b" (-) *BEE* "));
        0x1::string::append(&mut v10, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"  BEE + (-) *HIVE* "));
        0x1::string::append(&mut v10, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"  HIVE"));
        let v11 = 0xd133cc25988e2f007faae9d48c4c2c55b18438e3fa1e0b1691eb7f7ecc3856ca::hive_profile::borrow_app_from_profile<HiveChronicles>(&arg0.hive_chronicle_app_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v5, v11, 0x1::string::utf8(b"WITHDRAW_SUI"), v10, v9);
    }

    // decompiled from Move bytecode v6
}

