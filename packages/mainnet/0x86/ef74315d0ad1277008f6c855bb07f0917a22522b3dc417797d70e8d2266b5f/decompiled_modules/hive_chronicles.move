module 0x86ef74315d0ad1277008f6c855bb07f0917a22522b3dc417797d70e8d2266b5f::hive_chronicles {
    struct HiveChroniclesVault has key {
        id: 0x2::object::UID,
        hive_entry_cap: 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::HiveEntryCap,
        hive_chronicle_dof_cap: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability,
        airdrop_vault_dof_manager_cap: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::AdminDofOwnershipCapability,
        lockdrop_vault_dof_manager_cap: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::AdminDofOwnershipCapability,
        infusion_vault_dof_manager_cap: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::AdminDofOwnershipCapability,
        system_infusion_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, InfusionBuzz>,
        hive_chronicle_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes: 0x2::linked_table::LinkedTable<0x1::string::String, ChronicleBuzz>,
        welcome_buzzes_list: vector<0x1::string::String>,
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
        infusion_buzzes: 0x2::linked_table::LinkedTable<u64, UserInfusionBuzz>,
        infusion_count: u64,
        buzz_chains: 0x2::linked_table::LinkedTable<u64, vector<CreatorBuzz>>,
        total_buzz_chains: u64,
        chronicle_buzzes: 0x2::linked_table::LinkedTable<u64, UserChronicleBuzz>,
        total_logs: u64,
    }

    struct UserInfusionBuzz has store {
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct CreatorBuzz has store {
        timestamp: u64,
        narrative: 0x1::option::Option<0x1::string::String>,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        appreciations: 0x2::linked_table::LinkedTable<address, bool>,
        dialogues: 0x2::linked_table::LinkedTable<address, 0x1::string::String>,
    }

    struct UserChronicleBuzz has store {
        timestamp: u64,
        asset_id: 0x1::option::Option<u64>,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct NewChronicleBuzz has copy, drop {
        username: 0x1::string::String,
        log_index: u64,
        timestamp: u64,
        asset_id: 0x1::option::Option<u64>,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct NewInfusionBuzz has copy, drop {
        username: 0x1::string::String,
        infusion_count: u64,
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    public entry fun add_incentives_for_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::LockdropForPool<T1, T2>, arg3: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg4: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg5: u64, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::add_incentives_for_cetus_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for Cetus DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg3: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg4: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg5: u64, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::add_incentives_for_flowx_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for FlowX DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg3: &0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaAttackConfig, arg4: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg5: u64, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::add_incentives_for_kriya_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" additional HIVE tokens added as rewards for Kriya DEX's "));
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun add_incentives_for_lsd_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::LsdLockdropVault, arg3: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg4: u64, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" additional HIVE tokens added as rewards for SUI-hiveSUI Lockdrop Pool!"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72205355492d68697665535549204c6f636b64726f703a20"));
        0x1::string::append(&mut v0, make_num_with_decimals((0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::add_incentives_for_lsd_lockdrop(arg0, arg2, arg3, arg4, arg6) as u128), 6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg5, v0, 0x1::option::none<0x1::string::String>(), arg6);
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T1, T2, T3>, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::add_liquidity_to_degenhive<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg6);
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg5, v8.buzz, v8.gen_ai, arg6);
    }

    public entry fun claim_liquidity_from_cetus<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::LockdropForPool<T1, T2>, arg5: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10, v11, v12, v13, v14) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::claim_liquidity_from_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        internal_kraft_cetus_claim_liquidity_stream<T0>(arg2, arg6, arg1, v0, v1, v2, v3, v4, v5, v6, v8, v9, v10, v11, v12, v13, v14, arg7);
    }

    public entry fun claim_liquidity_from_rev_cetus<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::LockdropForPool<T2, T1>, arg5: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10, v11, v12, v13, v14) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::claim_liquidity_from_rev_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        internal_kraft_cetus_claim_liquidity_stream<T0>(arg2, arg6, arg1, v0, v1, v2, v3, v4, v5, v6, v8, v9, v10, v11, v12, v13, v14, arg7);
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::extract_liquidity_from_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v12, v11.gen_ai, arg8);
    }

    public entry fun extract_liquidity_from_kriya<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaAttackConfig, arg4: &mut 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T2>, arg6: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::extract_liquidity_from_kriya<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v12, v11.gen_ai, arg8);
    }

    public entry fun extract_liquidity_from_rev_flowx<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T2, T1>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, _, v8, v9, v10) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::extract_liquidity_from_rev_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v12, v11.gen_ai, arg8);
    }

    public entry fun infuse_sui_hsui_pool<T0>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropVault, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<0x2::sui::SUI, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg7: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg8: &mut 0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::infuse_sui_hsui_pool(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v4.buzz, v4.gen_ai, arg9);
    }

    public entry fun initialize_attack_on_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg3: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg9: u64, arg10: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        let v1 = 0x1::string::utf8(b"Vampire Attack on Cetus DEX's ");
        0x1::string::append(&mut v1, arg6);
        0x1::string::append(&mut v1, v0.buzz);
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204365747573204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v1, 0x2::address::to_string(0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_attack_on_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v1, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE "));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v1, v0.gen_ai, arg11);
    }

    public entry fun initialize_attack_on_flowx_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg3: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: u8, arg7: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg8: u64, arg9: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg10) {
            0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_attack_on_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
        } else {
            0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_attack_on_rev_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg9, v2, v1.gen_ai, arg11);
    }

    public entry fun initialize_attack_on_kriya_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg3: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T1, T2>, arg5: &mut 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg9: u64, arg10: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"KRIYA_ATTACK_INITIALIZED_FOR_POOL"));
        let v1 = 0x1::string::utf8(b"Vampire Attack on Kriya DEX's ");
        0x1::string::append(&mut v1, arg6);
        0x1::string::append(&mut v1, v0.buzz);
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204b72697961204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v1, 0x2::address::to_string(0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_attack_on_kriya_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v1, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE "));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v1, v0.gen_ai, arg11);
    }

    public entry fun initialize_lockdrop_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg3: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfileMappingStore, arg7: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg8: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: u8, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_FOR_POOL"));
        0x1::string::append(&mut arg11, v0.buzz);
        0x1::string::append(&mut arg11, 0x1::string::utf8(x"0a4c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut arg11, 0x2::address::to_string(0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_lockdrop_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, arg11, v0.gen_ai, arg18);
    }

    public entry fun initialize_lockdrops<T0>(arg0: &HiveChroniclesVault, arg1: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg3: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfileMappingStore, arg7: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg8: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg11: &0x2::clock::Clock, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_lockdrops(&arg0.hive_entry_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg11, arg10, v5.buzz, v5.gen_ai, arg22);
    }

    public entry fun migrate_user_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveDisperser, arg7: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::LockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::migrate_user_cetus_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked Cetus NFT positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d204365747573204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72206365747573206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"CETUS_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveDisperser, arg7: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::migrate_user_flowx_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked FlowX LP positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d20466c6f7758204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f7220466c6f7758206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"FLOWX_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_kriya_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveDisperser, arg7: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaAttackConfig, arg9: &mut 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::migrate_user_kriya_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked Kriya LP positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d204b72697961204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72204b72697961206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"KRIYA_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveDisperser, arg7: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::LockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::migrate_user_rev_cetus_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked Cetus NFT positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d204365747573204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f72206365747573206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"CETUS_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_rev_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveDisperser, arg7: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T0, T1, T2>, arg8: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::migrate_user_rev_flowx_position<T0, T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"Congratulations! locked FlowX LP positions for ");
        0x1::string::append(&mut v7, v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"20706f6f6c20207375636365737366756c6c792066696e616c697a656421200a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20484956452072657761726473206561726e65642066726f6d20466c6f7758204c6f636b757073203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v1 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" HIVE "));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a546f74616c20446567656e48697665204c5020746f6b656e73206c6f636b656420666f7220466c6f7758206c6f636b757020706f736974696f6e73203d2020"));
        0x1::string::append(&mut v7, make_num_with_decimals((v2 as u128), (6 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" LP tokens "));
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg10);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"FLOWX_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun migrate_user_sui_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveDisperser, arg7: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropVault, arg8: &mut 0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::migrate_user_sui_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
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
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg9);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v4, v8, 0x1::string::utf8(b"SUI_HIVE_SUI_POSITION_MIGRATED"), v7, 0x1::option::none<0x1::string::String>());
    }

    public entry fun claim_pol_from_streamer_buzz<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg5: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>, arg6: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::igems::IGEMS, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, v3, v4) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::claim_pol_from_streamer_buzz<T0>(arg1, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg3, arg5, arg6, arg7);
        let v5 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"POL_INFUSED_IN_POOL"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a0a504f4c204c5020746f6b656e73206b726166746564202d20"));
        0x1::string::append(&mut v5.buzz, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" LP Tokens"));
        if (v2 > 0) {
            0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a0a4947454d53204b726166746564202d20"));
            0x1::string::append(&mut v5.buzz, make_num_with_decimals((v2 as u128), 9));
            0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" IGEMS"));
            0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a0a4947454d5320646973747269627574656420616d6f6e6720496e667573696f6e207061727469636970616e7473202d20"));
            0x1::string::append(&mut v5.buzz, make_num_with_decimals((v3 as u128), 9));
            0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" IGEMS"));
            0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a0a582d4947454d53204c5020746f6b656e73206b7261667465642026206275726e74202d20"));
            0x1::string::append(&mut v5.buzz, make_num_with_decimals((v4 as u128), 6));
            0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" LP tokens"));
        };
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v5.buzz, v5.gen_ai, arg7);
    }

    public entry fun claim_rewards_and_shares_0_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg5: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::claim_rewards_and_shares_0_fruits<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v7, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v7, v0, v1, v2, v3, v4, v5);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v12 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v11);
        0x1::string::append(&mut v10, v12.buzz);
        let v13 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v13, v11, v10, v12.gen_ai);
    }

    public entry fun claim_rewards_and_shares_1_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg5: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::claim_rewards_and_shares_1_fruits<T0, T1>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v8, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v11 = make_buzz_for_infusion_rewards_claim(v8, v0, v1, v2, v3, v4, v5);
        let v12 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v13 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v12);
        0x1::string::append(&mut v11, v13.buzz);
        let v14 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v8, v14, v12, v11, v13.gen_ai);
    }

    public entry fun claim_rewards_and_shares_2_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg5: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, _, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::claim_rewards_and_shares_2_fruits<T0, T1, T2>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v9, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v12 = make_buzz_for_infusion_rewards_claim(v9, v0, v1, v2, v3, v4, v5);
        let v13 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v14 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v13);
        0x1::string::append(&mut v12, v14.buzz);
        let v15 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v9, v15, v13, v12, v14.gen_ai);
    }

    public entry fun claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg5: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, _, _, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v10, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v13 = make_buzz_for_infusion_rewards_claim(v10, v0, v1, v2, v3, v4, v5);
        let v14 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v15 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v14);
        0x1::string::append(&mut v13, v15.buzz);
        let v16 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v10, v16, v14, v13, v15.gen_ai);
    }

    public entry fun delegate_hive_airdrop<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::delegate_hive_airdrop<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(x"2a2a555344432d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" HIVE delegated from airdrop rewards for Infusion phase"));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v7, 0x1::string::utf8(b"DELEGATE_HIVE_AIRDROP"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun delegate_hive_from_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::delegate_hive_from_lockdrop<T0>(arg0, &arg1.hive_entry_cap, &arg1.infusion_vault_dof_manager_cap, arg2, arg3, arg4, arg5, arg6);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(x"2a2a555344432d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" HIVE delegated from lockdrop rewards for Infusion phase"));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"DELEGATE_HIVE_LOCKDROP"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun infuse_hive_incentives<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::infuse_hive_incentives<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, arg2, arg3, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INFUSE_HIVE_INCENTIVES"));
        let v1 = make_num_with_decimals((arg5 as u128), 6);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"HIVE tokens have been added as rewards for our Infusion Phase! "));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v1, v0.gen_ai, arg6);
    }

    public entry fun infuse_usdc_hive_pool<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropRewardsCapabilityHolder, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg5: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>, arg6: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg7: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::infuse_usdc_hive_pool<T0>(arg1, &arg0.hive_entry_cap, arg2, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg3, arg5, arg6, arg7);
        let v3 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"USDC_HIVE_POOL_INFUSED"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a0a0a5553444320496e6675736564202d20"));
        0x1::string::append(&mut v3.buzz, make_num_with_decimals((v0 as u128), 6));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" USDC"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a4849564520496e6675736564202d20"));
        0x1::string::append(&mut v3.buzz, make_num_with_decimals((v1 as u128), 6));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" HIVE"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a4c5020746f6b656e73204b726166746564202d20"));
        0x1::string::append(&mut v3.buzz, make_num_with_decimals((v2 as u128), 6));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg4, v3.buzz, v3.gen_ai, arg8);
    }

    public entry fun initialize_infusion_vault<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg5: 0x2::coin::TreasuryCap<0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::igems::IGEMS>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg8: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfileMappingStore, arg9: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::initialize_infusion_vault<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg4, arg5, arg6, arg7, arg8, arg2, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_INFUSION_VAULT"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg18);
    }

    public entry fun lock_in_x_hive_pool_addr<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg2: &0x2::clock::Clock, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg6: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg7: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg8: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg9: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x2::coin::CoinMetadata<T0>, arg12: &0x2::coin::CoinMetadata<T1>, arg13: vector<u64>, arg14: 0x1::option::Option<vector<u256>>, arg15: 0x1::option::Option<vector<u64>>, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"LOCK_IN_X_HIVE_POOL_ADDR"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a555344432d4849564520506f6f6c3a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::lock_in_x_hive_pool_addr<T0, T1, T2>(arg2, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg3, arg4, arg6, arg7, arg8, arg9, 0x2::coin::into_balance<0x2::sui::SUI>(arg10), arg11, arg12, arg13, arg14, arg15, arg16)));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg2, arg5, v0.buzz, v0.gen_ai, arg16);
    }

    public entry fun stake_lp_tokens_0_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg2: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg3: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::stake_lp_tokens_0_fruits<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_one_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg2: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg3: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::stake_lp_tokens_one_fruits<T0, T1>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_three_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg2: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg3: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::stake_lp_tokens_three_fruits<T0, T1, T2, T3>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_lp_tokens_two_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg2: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolsGovernor, arg3: &mut 0xe4fe92f1e2c78572cfb71fa8d8b531049f065f8f5eb24b85a8f545a12c15ba5d::dex_dao::PoolHive<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE, 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::stake_lp_tokens_two_fruits<T0, T1, T2>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_hive<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::withdraw_hive<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3);
    }

    public entry fun add_to_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::add_to_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v1, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"2a2a5355492d68697665535549204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v4, make_num_with_decimals((arg5 as u128), 9));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" SUI Locked for "));
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v4, 0x1::string::utf8(x"205765656b7321200a"));
        0x1::string::append(&mut v4, 0x1::string::utf8(b"Pro-rata SUI-hiveSUI degenhive LP tokens and vested HIVE rewards to be received will be calculated ofter the lockdrop phase is over! #DegenHiveOdyssey"));
        let v5 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v1, v5, 0x1::string::utf8(b"ADD_SUI_FOR_LSD_LOCKDROP"), v4, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x41f2229428a930586501296070b6482cdd731b5536784a51472fb56e82019e7e::lsd_lockdrop::withdraw_from_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6);
        let (_, v1, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"2a2a5355492d68697665535549204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v4, make_num_with_decimals((arg4 as u128), 9));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" SUI withdrawn from SUI-hiveSUI Lockdrop of "));
        0x1::string::append(&mut v4, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v4, 0x1::string::utf8(x"207765656b7321200a20"));
        let v5 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v1, v5, 0x1::string::utf8(b"WITHDRAW_SUI_FROM_LSD_LOCKDROP"), v4, 0x1::option::none<0x1::string::String>());
    }

    public entry fun add_hive_for_airdrop<T0>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg5: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x4f2905db8a9e170daaf016ae13e2dea79857d25e655b8befd118d2304a6464cc::airdrop::add_hive_for_airdrop(arg2, &arg1.airdrop_vault_dof_manager_cap, arg3, arg5, arg6, arg7);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"ADD_HIVE_FOR_AIRDROP"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg7);
    }

    public entry fun claim_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: u64, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x4f2905db8a9e170daaf016ae13e2dea79857d25e655b8befd118d2304a6464cc::airdrop::claim_hive_airdrop(&arg0.airdrop_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v1, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"Welcome to DegenHive, @");
        0x1::string::append(&mut v4, v1);
        0x1::string::append(&mut v4, 0x1::string::utf8(b"! You've claimed "));
        0x1::string::append(&mut v4, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" HIVE Tokens, Currently safeguarded in HiveAirdropHolder dynamic object stored with your HiveProfile!"));
        let v5 = 0x1::string::utf8(b"CLAIM_AIRDROP");
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v5);
        0x1::string::append(&mut v4, v6.buzz);
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v1, v7, v5, v4, v6.gen_ai);
    }

    public entry fun initialize_airdrop_vault<T0>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg5: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x4f2905db8a9e170daaf016ae13e2dea79857d25e655b8befd118d2304a6464cc::airdrop::initialize_airdrop_vault(arg2, &arg1.airdrop_vault_dof_manager_cap, arg5, arg3, arg6, arg7, arg8, arg9);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_AIRDROP_VAULT"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg9);
    }

    public entry fun transfer_unclaimed_hive<T0>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg5: &mut 0x2::tx_context::TxContext) {
        0x4f2905db8a9e170daaf016ae13e2dea79857d25e655b8befd118d2304a6464cc::airdrop::transfer_unclaimed_hive(&arg1.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_AIRDROP_COMPLETE"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg5);
    }

    public entry fun update_airdrop_vault<T0>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &HiveChroniclesVault, arg2: &0x2::clock::Clock, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x4f2905db8a9e170daaf016ae13e2dea79857d25e655b8befd118d2304a6464cc::airdrop::update_airdrop_vault(&arg1.airdrop_vault_dof_manager_cap, arg3, arg5, arg6, arg7);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_AIRDROP_VAULT_UPDATED"));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg2, arg4, v0.buzz, v0.gen_ai, arg7);
    }

    public entry fun withdraw_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v4 = 0x1::string::utf8(b"You've withdrawn ");
        0x1::string::append(&mut v4, make_num_with_decimals((0x4f2905db8a9e170daaf016ae13e2dea79857d25e655b8befd118d2304a6464cc::airdrop::withdraw_hive_airdrop(&arg0.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5) as u128), 6));
        0x1::string::append(&mut v4, 0x1::string::utf8(b" HIVE GEMS, @"));
        0x1::string::append(&mut v4, v1);
        let v5 = 0x1::string::utf8(b"WITHDRAW_AIRDROP");
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v5);
        0x1::string::append(&mut v4, v6.buzz);
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg4, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v1, v7, v5, v4, v6.gen_ai);
    }

    public entry fun add_welcome_buzz(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun infuse_usdc<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::deposit_usdc<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(x"2a2a555344432d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), 6));
        0x1::string::append(&mut v6, v3);
        0x1::string::append(&mut v6, 0x1::string::utf8(b"  USDC infused for USDC-HIVE pool."));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v7, 0x1::string::utf8(b"INFUSE_USDC"), v6, 0x1::option::none<0x1::string::String>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_rev_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg3: &0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: u8, arg8: 0x2::coin::Coin<0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HIVE>, arg9: u64, arg10: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        let v1 = 0x1::string::utf8(b"Vampire Attack on Cetus DEX's ");
        0x1::string::append(&mut v1, arg6);
        0x1::string::append(&mut v1, v0.buzz);
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204365747573204c6f636b64726f7020506f6f6c3a20"));
        0x1::string::append(&mut v1, 0x2::address::to_string(0x34be3cb9380d617670d20b7443d74b012f9dbe6b9da9a17314fd5c59fc51e3e0::lockdrop::initialize_attack_on_reverse_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg11)));
        0x1::string::append(&mut v1, 0x1::string::utf8(x"0a0a204849564520666f7220646973747269627574696f6e3a20"));
        0x1::string::append(&mut v1, make_num_with_decimals((arg9 as u128), 6));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE "));
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v1, v0.gen_ai, arg11);
    }

    public entry fun initialize_hive_chronicles(arg0: 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::HiveEntryCap, arg1: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::ProfileDofOwnershipCapability, arg2: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::AdminDofOwnershipCapability, arg3: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::AdminDofOwnershipCapability, arg4: 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::AdminDofOwnershipCapability, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveChroniclesVault{
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
        };
        0x2::transfer::share_object<HiveChroniclesVault>(v0);
    }

    fun internal_kraft_cetus_claim_liquidity_stream<T0>(arg0: &HiveChroniclesVault, arg1: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::HiveVault, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: u8, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
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
        0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg2, arg1, arg3, v0.gen_ai, arg17);
    }

    public entry fun kraft_hive_profile(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfileMappingStore, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = kraft_new_hive_chronicle(arg10);
        let v1 = *0x1::vector::borrow<0x1::string::String>(&arg0.welcome_buzzes_list, ((0x2::clock::timestamp_ms(arg1) % 0x1::vector::length<0x1::string::String>(&arg0.welcome_buzzes_list)) as u64));
        let v2 = *0x2::linked_table::borrow<0x1::string::String, ChronicleBuzz>(&arg0.welcome_buzzes, v1);
        let v3 = &mut v0;
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), arg8, v3, 0x1::option::none<u64>(), v1, v2.user_log, v2.gen_ai, false, arg10);
        let v4 = NewChronicleBuzz{
            username  : arg8,
            log_index : v0.total_logs,
            timestamp : 0x2::clock::timestamp_ms(arg1),
            asset_id  : 0x1::option::none<u64>(),
            move_type : v1,
            user_log  : v2.user_log,
            gen_ai    : v2.gen_ai,
        };
        0x2::event::emit<NewChronicleBuzz>(v4);
        0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::kraft_hive_profile_and_return_sui<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10), 0x2::tx_context::sender(arg10), arg10);
    }

    fun kraft_new_hive_chronicle(arg0: &mut 0x2::tx_context::TxContext) : HiveChronicles {
        HiveChronicles{
            id                : 0x2::object::new(arg0),
            infusion_buzzes   : 0x2::linked_table::new<u64, UserInfusionBuzz>(arg0),
            infusion_count    : 0,
            buzz_chains       : 0x2::linked_table::new<u64, vector<CreatorBuzz>>(arg0),
            total_buzz_chains : 0,
            chronicle_buzzes  : 0x2::linked_table::new<u64, UserChronicleBuzz>(arg0),
            total_logs        : 0,
        }
    }

    public entry fun lock_flowx_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::lock_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** FlowX's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg6 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens withdrawn from FlowX lockup of "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" weeks!"));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_ADDED_FOR_FLOWX"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun lock_kriya_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::lock_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** Kriya's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg6 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens Locked for "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"205765656b7321200a"));
        0x1::string::append(&mut v6, 0x1::string::utf8(b"Pro-rata degenhive LP tokens and vested HIVE rewards to be received will be calculated ofter the lockdrop phase is over! #DegenHiveOdyssey"));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg8);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_DEPOSITED_TO_KRIYA"), v6, 0x1::option::none<0x1::string::String>());
    }

    fun make_buzz_for_infusion_rewards_claim(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"- [INFUSION-BUZZ] #");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  claimed rewards and shares for participation in USDC-HIVE Infusion -::- "));
        if (arg3 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a484956452047454d5320636c61696d65642061732070617274696369706174696f6e2072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg3 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE_GEMS"));
        };
        if (arg2 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a484956452047454d5320636c61696d6564206173207374616b696e672072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg2 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE_GEMS"));
        };
        if (arg1 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a555344432d48495645204c5020546f6b656e7320756e626f6e646564202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg1 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens"));
        };
        if (arg4 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a555344432d48495645204c5020546f6b656e7320756e6c6f636b6564202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg4 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens"));
        };
        if (arg5 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a504f4c20546f6b656e7320636c61696d65642061732072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg5 as u128), 6));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" POL Tokens"));
        };
        if (arg6 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4947454d5320546f6b656e7320636c61696d65642061732070617274696369706174696f6e2072657761726473202d20"));
            0x1::string::append(&mut v0, make_num_with_decimals((arg6 as u128), 9));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" IGEMS Tokens"));
        };
        v0
    }

    fun make_new_chronicle_log(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            assert!(0x1::string::length(&arg5) < 180, 9746);
        };
        let v0 = arg2.total_logs;
        let v1 = UserChronicleBuzz{
            timestamp : arg0,
            asset_id  : arg3,
            move_type : arg4,
            user_log  : arg5,
            gen_ai    : arg6,
            likes     : 0x2::linked_table::new<address, bool>(arg8),
        };
        0x2::linked_table::push_back<u64, UserChronicleBuzz>(&mut arg2.chronicle_buzzes, v0, v1);
        arg2.total_logs = arg2.total_logs + 1;
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

    fun make_num_with_decimals(arg0: u128, arg1: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::math::pow(10, (arg1 as u128));
        let v1 = 0x1::string::utf8(u64_to_ascii(((arg0 / v0) as u64)));
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v1, 0x1::string::utf8(u64_to_ascii(((arg0 % v0) as u64))));
        v1
    }

    public entry fun new_add_system_buzz(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::LockdropForPool<T0, T1>, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xf92497ee98563675de7fa9cbeff0bd995e66d049b935fdac078af13843f93787::cetus_vampire_attack::stake_cetus_position<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v4, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v7 = 0x1::string::utf8(b"** CETUS's ");
        0x1::string::append(&mut v7, v1);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" - NFT position with liquidity "));
        0x1::string::append(&mut v7, make_num_with_decimals((v0 as u128), (v2 as u64)));
        0x1::string::append(&mut v7, 0x1::string::utf8(b" locked for "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"205765656b7321200a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Once locked, cetus LP positions cannot be withdrawn from the Lockdrop pool."));
        let v8 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg7);
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

    public entry fun withdraw_flowx_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e0f9a6e7da9a245716ead8726b609ca8ff02bb7106f6cfa90c7d142438bc0d1::flowx_vampire_attack::withdraw_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** FlowX's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens withdrawn from FlowX lockup of "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" weeks!"));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_WITHDRAWN_FROM_FLOWX"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_kriya_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg4: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xed529b385e6ea478f47b7cc23d5d5be679b425e69068a4952a6c250fcfdd586::kriya_vampire_attack::withdraw_lp_tokens<T0, T1>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg4);
        let v6 = 0x1::string::utf8(b"** Kriya's ");
        0x1::string::append(&mut v6, v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"204c6f636b64726f70205175657374205570646174652a2a200a"));
        0x1::string::append(&mut v6, make_num_with_decimals((arg5 as u128), (v1 as u64)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" LP tokens withdrawn from Kriya lockup of "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" weeks!"));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg1.hive_chronicle_dof_cap, arg4, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg0), v3, v7, 0x1::string::utf8(b"LP_WITHDRAWN_FROM_KRIYA"), v6, 0x1::option::none<0x1::string::String>());
    }

    public entry fun withdraw_usdc_from_infusion<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveManager, arg3: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x40884712d3d5e1842b1a0fad414c8aeb4277f3ffd2896796513f72df4e6d61e1::infusion::handle_withdraw_usdc<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5);
        let (_, v3, _, _) = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(x"2a2a555344432d4849564520496e667573696f6e205570646174652a2a200a");
        0x1::string::append(&mut v6, make_num_with_decimals((arg4 as u128), 6));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" USDC withdrawn from USDC-HIVE infusion pool. "));
        let v7 = 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v7, 0x1::string::utf8(b"WITHDRAW_USDC"), v6, 0x1::option::none<0x1::string::String>());
    }

    // decompiled from Move bytecode v6
}

