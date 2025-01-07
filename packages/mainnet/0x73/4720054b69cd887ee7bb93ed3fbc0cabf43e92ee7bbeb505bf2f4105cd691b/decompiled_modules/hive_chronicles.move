module 0xc0dbc170afe74f034e11226ba6a3cb03d27e77424624af74d6cd102bc34e8aa0::hive_chronicles {
    struct HiveChroniclesVault has key {
        id: 0x2::object::UID,
        hive_entry_cap: 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap,
        hive_chronicle_dof_cap: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability,
        airdrop_vault_dof_manager_cap: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::AdminDofOwnershipCapability,
        lockdrop_vault_dof_manager_cap: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::AdminDofOwnershipCapability,
        infusion_vault_dof_manager_cap: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::AdminDofOwnershipCapability,
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
        liquid_hive: u64,
        vested_hive: u64,
        chronicle_buzzes: 0x2::linked_table::LinkedTable<u64, UserChronicleBuzz>,
        total_logs: u64,
    }

    struct UserInfusionBuzz has store {
        timestamp: u64,
        infusion_type: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
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

    public entry fun add_hive_for_airdrop<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x52cf3212c384ab54e89bd8efeebcb780929c75dc96476c5222f0cc308d30359::airdrop::add_hive_for_airdrop(arg1, &arg0.airdrop_vault_dof_manager_cap, arg2, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"ADD_HIVE_FOR_AIRDROP"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a4849564520546f6b656e73204164646564202d20"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun claim_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x52cf3212c384ab54e89bd8efeebcb780929c75dc96476c5222f0cc308d30359::airdrop::claim_hive_airdrop(&arg0.airdrop_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = 0x1::string::utf8(b"HIVE Airdrop Claimed by #");
        let (_, v2, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        0x1::string::append(&mut v0, v2);
        let v5 = 0x1::string::utf8(b"CLAIM_AIRDROP");
        let v6 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v5);
        0x1::string::append(&mut v0, v6.buzz);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4849564520436c61696d6564202d20"));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg4)));
        let v7 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v2, v7, v5, v0, v6.gen_ai);
    }

    public entry fun initialize_airdrop_vault<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg5: vector<vector<u8>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x52cf3212c384ab54e89bd8efeebcb780929c75dc96476c5222f0cc308d30359::airdrop::initialize_airdrop_vault(arg1, &arg0.airdrop_vault_dof_manager_cap, arg4, arg2, arg5, arg6, arg7, arg8);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_AIRDROP_VAULT"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg8);
    }

    public entry fun transfer_unclaimed_hive<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_AIRDROP_COMPLETE"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a484956452041697264726f70205661756c742055706461746564202d20"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(b" HIVE transferred to treasury: "));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(u64_to_ascii(0x52cf3212c384ab54e89bd8efeebcb780929c75dc96476c5222f0cc308d30359::airdrop::transfer_unclaimed_hive(&arg0.airdrop_vault_dof_manager_cap, arg1, arg2, arg3, arg4))));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg4);
    }

    public entry fun update_airdrop_vault<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: vector<vector<u8>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x52cf3212c384ab54e89bd8efeebcb780929c75dc96476c5222f0cc308d30359::airdrop::update_airdrop_vault(&arg0.airdrop_vault_dof_manager_cap, arg2, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_AIRDROP_VAULT_UPDATED"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a484956452041697264726f70205661756c742055706461746564202d20"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(b" New Claim End Timestamp: "));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(b" ms"));
        if (0x1::vector::length<vector<u8>>(&arg4) > 0) {
            0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a4d65726b6c65205472656520526f6f74732068617665206265656e207570646174656421"));
        };
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun withdraw_hive_airdrop(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x52cf3212c384ab54e89bd8efeebcb780929c75dc96476c5222f0cc308d30359::airdrop::withdraw_hive_airdrop(&arg0.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5);
        let v1 = 0x1::string::utf8(u64_to_ascii(v0));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" HIVE GEMS withdrawn from Airdrop by #"));
        let (_, v3, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg4);
        0x1::string::append(&mut v1, v3);
        let v6 = 0x1::string::utf8(b"WITHDRAW_AIRDROP");
        let v7 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v6);
        let v8 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg4, arg5);
        v8.liquid_hive = v8.liquid_hive + v0;
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v8, v6, v1, v7.gen_ai);
    }

    public entry fun claim_pol_from_streamer_buzz<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg5: &mut 0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::PoolRegistry, arg6: &mut 0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LiquidityPool<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::claim_pol_from_streamer_buzz<T0>(arg1, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg3, arg5, arg4, arg6, arg7);
        let v3 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"POL_INFUSED_IN_POOL"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a0a0a504f4c20496e667573656420696e20582d4849564520506f6f6c202d20"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" LP Tokens"));
        if (v2 > 0) {
            0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a0a0a4947454d53204b726166746564202d20"));
            0x1::string::append(&mut v3.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000000)));
            0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" IGEMS"));
        };
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg4, v3.buzz, v3.gen_ai, arg7);
    }

    public entry fun claim_rewards_and_shares_no_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::claim_rewards_and_shares_no_fruits<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v7, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v10 = make_buzz_for_infusion_rewards_claim(v7, v0, v1, v2, v3, v4, v5);
        let v11 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v12 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v11);
        0x1::string::append(&mut v10, v12.buzz);
        let v13 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v7, v13, v11, v10, v12.gen_ai);
    }

    public entry fun claim_rewards_and_shares_one_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::claim_rewards_and_shares_one_fruits<T0, T1>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v8, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v11 = add_fruit_claim_msg<T1>(make_buzz_for_infusion_rewards_claim(v8, v0, v1, v2, v3, v4, v5), v6);
        let v12 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v13 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v12);
        0x1::string::append(&mut v11, v13.buzz);
        let v14 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v8, v14, v12, v11, v13.gen_ai);
    }

    public entry fun claim_rewards_and_shares_three_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::claim_rewards_and_shares_three_fruits<T0, T1, T2, T3>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v10, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v13 = add_fruit_claim_msg<T3>(add_fruit_claim_msg<T2>(add_fruit_claim_msg<T1>(make_buzz_for_infusion_rewards_claim(v10, v0, v1, v2, v3, v4, v5), v6), v7), v8);
        let v14 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v15 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v14);
        0x1::string::append(&mut v13, v15.buzz);
        let v16 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v10, v16, v14, v13, v15.gen_ai);
    }

    public entry fun claim_rewards_and_shares_two_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::claim_rewards_and_shares_two_fruits<T0, T1, T2>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg4, arg5, arg3, arg6, arg7);
        let (_, v9, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v12 = add_fruit_claim_msg<T2>(add_fruit_claim_msg<T1>(make_buzz_for_infusion_rewards_claim(v9, v0, v1, v2, v3, v4, v5), v6), v7);
        let v13 = 0x1::string::utf8(b"CLAIM_INFUSION_REWARDS");
        let v14 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v13);
        0x1::string::append(&mut v12, v14.buzz);
        let v15 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg7);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v9, v15, v13, v12, v14.gen_ai);
    }

    public entry fun delegate_hive_airdrop<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::delegate_hive_airdrop<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg2, arg3, arg4, arg5);
        let (_, v3, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(b"- [INFUSION-BUZZ] #");
        0x1::string::append(&mut v6, v3);
        0x1::string::append(&mut v6, 0x1::string::utf8(b"  delegated "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg4 / 1000000)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" HIVE for `expected` "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" more HIVE GEMS. "));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" Total Expected HIVE GEMS: "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        let v7 = 0x1::string::utf8(b"DELEGATE_HIVE_AIRDROP");
        let v8 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v7);
        0x1::string::append(&mut v6, v8.buzz);
        let v9 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v9, v7, v6, v8.gen_ai);
    }

    public entry fun infuse_hive_incentives<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::infuse_hive_incentives<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, arg2, arg3, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INFUSE_HIVE_INCENTIVES"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun infuse_usdc_hive_pool<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LiquidityPool<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::infuse_usdc_hive_pool<T0>(arg1, &arg0.infusion_vault_dof_manager_cap, &arg0.airdrop_vault_dof_manager_cap, arg2, arg4);
        let v3 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"X_HIVE_POOL_INFUSED"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a0a0a5553444320496e667573656420696e20582d4849564520506f6f6c202d20"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" USDC"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a4849564520496e667573656420696e20582d4849564520506f6f6c202d20"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" HIVE"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(x"0a4c5020746f6b656e73204b726166746564202d20"));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000)));
        0x1::string::append(&mut v3.buzz, 0x1::string::utf8(b" LP Tokens"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v3.buzz, v3.gen_ai, arg5);
    }

    public entry fun initialize_infusion_vault<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg5: 0x2::coin::TreasuryCap<0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::igems::IGEMS>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2e9498df0f78cd3fed9eb78a58ab3a622dc43df1332da201bb7d6a12070bbb02::hsui_vault::HSuiVault, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfileMappingStore, arg9: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HSuiDisperser<0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::hsui::HSUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::initialize_infusion_vault<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg4, arg5, arg6, arg7, arg8, arg2, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_INFUSION_VAULT"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg15);
    }

    public entry fun lock_in_x_hive_pool_addr<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg5: &mut 0x2e9498df0f78cd3fed9eb78a58ab3a622dc43df1332da201bb7d6a12070bbb02::hsui_vault::HSuiVault, arg6: &mut 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::Config, arg7: &mut 0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::PoolRegistry, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HSuiDisperser<0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: vector<u64>, arg13: 0x1::option::Option<vector<u256>>, arg14: 0x1::option::Option<vector<u64>>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"LOCK_IN_X_HIVE_POOL_ADDR"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a582d4849564520506f6f6c20416464726573733a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::lock_in_x_hive_pool_addr<T0, T1, T2>(arg1, &arg0.hive_entry_cap, &arg0.infusion_vault_dof_manager_cap, arg2, arg3, arg5, arg6, arg7, arg8, 0x2::coin::into_balance<0x2::sui::SUI>(arg9), arg10, arg11, arg12, arg13, arg14, arg15)));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg4, v0.buzz, v0.gen_ai, arg15);
    }

    public entry fun stake_lp_tokens_no_fruits<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::stake_lp_tokens_no_fruits<T0>(&arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"X_HIVE_POOL_STAKED"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a555344432d48495645204c5020546f6b656e73205374616b656420666f7220484956452d47454d5320616e64204265652d4672756974732120"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun stake_lp_tokens_one_fruits<T0, T1>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::stake_lp_tokens_one_fruits<T0, T1>(&arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"X_HIVE_POOL_STAKED"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a555344432d48495645204c5020546f6b656e73205374616b656420666f7220484956452d47454d5320616e64204265652d4672756974732120"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun stake_lp_tokens_three_fruits<T0, T1, T2, T3>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::stake_lp_tokens_three_fruits<T0, T1, T2, T3>(&arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"X_HIVE_POOL_STAKED"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a555344432d48495645204c5020546f6b656e73205374616b656420666f7220484956452d47454d5320616e64204265652d4672756974732120"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun stake_lp_tokens_two_fruits<T0, T1, T2>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg4: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolsGovernor, arg5: &mut 0x33711057b3d7b51cd781d9d9dbb4fd69cf03f0e14ea19949deb9214b47132790::dex_dao::PoolHive<0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LP<T0, 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::stake_lp_tokens_two_fruits<T0, T1, T2>(&arg0.infusion_vault_dof_manager_cap, arg2, arg4, arg5, arg6);
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"X_HIVE_POOL_STAKED"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a0a555344432d48495645204c5020546f6b656e73205374616b656420666f7220484956452d47454d5320616e64204265652d4672756974732120"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg1, arg3, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun stake_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::LockdropForPool<T1, T2>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg10: u128, arg11: u64, arg12: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b" Participation share increased in Cetus Lockup!"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a546f74616c2065787065637465642048495645207265776172647320766961204365747573204c6f636b64726f703a20"));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::stake_cetus_position<T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13) / 1000000)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg12, v0, 0x1::option::none<0x1::string::String>(), arg13);
    }

    public entry fun unstake_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::LockdropForPool<T1, T2>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: u128, arg10: u64, arg11: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b" Participation share decreased in Cetus Lockup!"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a546f74616c2065787065637465642048495645207265776172647320766961204365747573204c6f636b64726f703a20"));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::unstake_cetus_position<T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12) / 1000000)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg11, v0, 0x1::option::none<0x1::string::String>(), arg12);
    }

    fun add_fruit_claim_msg<T0>(arg0: 0x1::string::String, arg1: u64) : 0x1::string::String {
        if (arg1 > 0) {
            0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a42656546727569747320636c61696d6564202d20"));
            0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a54797065202d20"));
            0x1::string::append(&mut arg0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
            0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a416d6f756e742028776974686f757420707265636973696f6e29202d20"));
            0x1::string::append(&mut arg0, 0x1::string::utf8(u64_to_ascii(arg1)));
        };
        arg0
    }

    public entry fun add_incentives_for_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::LockdropForPool<T1, T2>, arg3: &0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::CetusAttackConfig, arg4: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg5: u64, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::add_incentives_for_cetus_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_ADDED_FOR_LOCKDROP"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" HIVE added as incentives for CETUS's "));
        0x1::string::append(&mut v2.buzz, v1);
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(u64_to_ascii(v0)));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2.buzz, v2.gen_ai, arg7);
    }

    public entry fun add_incentives_for_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg3: &0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxAttackConfig, arg4: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg5: u64, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::add_incentives_for_flowx_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_ADDED_FOR_LOCKDROP"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" HIVE added as incentives for FlowX's "));
        0x1::string::append(&mut v2.buzz, v1);
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(u64_to_ascii(v0)));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2.buzz, v2.gen_ai, arg7);
    }

    public entry fun add_incentives_for_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg3: &0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaAttackConfig, arg4: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg5: u64, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::add_incentives_for_kriya_pool<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7);
        let v2 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_ADDED_FOR_LOCKDROP"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" HIVE added as incentives for Kriya's "));
        0x1::string::append(&mut v2.buzz, v1);
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" Lockdrop Pool!"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e74697665733a20"));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(u64_to_ascii(v0)));
        0x1::string::append(&mut v2.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2.buzz, v2.gen_ai, arg7);
    }

    public entry fun add_incentives_for_lsd_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xdccda0e1097eb49a7e1fd237fd4f42512af505819dae89b5aa45e4574ee3b38b::lsd_lockdrop::LsdLockdropVault, arg3: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg4: u64, arg5: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"HIVE_ADDED_FOR_LOCKDROP"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(u64_to_ascii(arg4)));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(b" HIVE added as incentives for SUI-hiveSUI Lockdrop!"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72205355492d68697665535549204c6f636b64726f703a20"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(u64_to_ascii(0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::add_incentives_for_lsd_lockdrop(arg0, arg2, arg3, arg4, arg6))));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg5, v0.buzz, v0.gen_ai, arg6);
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2, T3>(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LiquidityPool<T1, T2, T3>, arg5: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::add_liquidity_to_degenhive<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg6);
        let v4 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"LIQUIDITY_ADDED_TO_DEGENHIVE"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b"Total DegenHive's LP krafted: "));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" LP"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a5368617265206f66204365747573204c6f636b64726f703a20"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" LP"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a5368617265206f66204b72697961204c6f636b64726f703a20"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" LP"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a5368617265206f6620466c6f7758204c6f636b64726f703a20"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v3 / 1000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" LP"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg5, v4.buzz, v4.gen_ai, arg6);
    }

    public entry fun add_system_buzz(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun add_to_lsd_lockup_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xdccda0e1097eb49a7e1fd237fd4f42512af505819dae89b5aa45e4574ee3b38b::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdccda0e1097eb49a7e1fd237fd4f42512af505819dae89b5aa45e4574ee3b38b::lsd_lockdrop::add_to_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg8);
        let v2 = 0x1::string::utf8(u64_to_ascii(arg5 / 1000000000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" SUI added to LSD Lockup of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" weeks, for an expected increase of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE rewards!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c2065787065637465642048495645207265776172647320766961204c5344204c6f636b64726f703a20"));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg7, v2, 0x1::option::none<0x1::string::String>(), arg8);
    }

    public entry fun add_welcome_buzz(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun claim_liquidity_from_cetus<T0, T1, T2, T3>(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::CetusAttackConfig, arg4: &mut 0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::LockdropForPool<T1, T2>, arg5: &mut 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::claim_liquidity_from_cetus<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7);
        let v9 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_LIQUIDITY_CLAIMED"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b"Total Liquidity Claimed: "));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(((v0 / (1000000 as u128)) as u64))));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" CETUS LP"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a546f74616c20576569676874656420556e6974733a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(((v1 / (1000000 as u128)) as u64))));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" Units"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a58204c697175696469747920436c61696d65643a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" X"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a59204c697175696469747920436c61696d65643a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v3 / 1000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" Y"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a582046656520436c61696d65643a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v4 / 1000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" X"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a592046656520436c61696d65643a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v5 / 1000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" Y"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a535549204561726e65643a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v6 / 1000000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" SUI"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a4345545553204561726e65643a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v7 / 1000000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" CETUS"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72204365747573204c6f636b64726f703a20"));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(u64_to_ascii(v8 / 1000000)));
        0x1::string::append(&mut v9.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg6, v9.buzz, v9.gen_ai, arg7);
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2, T3>(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxAttackConfig, arg4: &mut 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::extract_liquidity_from_flowx<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let v5 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"FLOWX_LIQUIDITY_CLAIMED"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b"Total Liquidity Claimed: "));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(((v0 / (1000000 as u128)) as u64))));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" FLOWX LP"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a546f74616c20576569676874656420556e6974733a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(((v1 / (1000000 as u128)) as u64))));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" Units"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a58204c697175696469747920436c61696d65643a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(v3 / 1000000)));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" X"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a59204c697175696469747920436c61696d65643a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(v4 / 1000000)));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" Y"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f7220466c6f7778204c6f636b64726f703a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000)));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v5.buzz, v5.gen_ai, arg8);
    }

    public entry fun extract_liquidity_from_kriya<T0, T1, T2, T3>(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaAttackConfig, arg4: &mut 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg5: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T2>, arg6: &mut 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::extract_liquidity_from_kriya<T1, T2, T3>(arg1, &arg2.hive_entry_cap, arg7, arg6, arg3, arg4, arg5, arg8);
        let v5 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"KRIYA_LIQUIDITY_CLAIMED"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b"Total Liquidity Claimed: "));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(((v0 / (1000000 as u128)) as u64))));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" KRIYA LP"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a546f74616c20576569676874656420556e6974733a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(((v1 / (1000000 as u128)) as u64))));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" Units"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a58204c697175696469747920436c61696d65643a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(v3 / 1000000)));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" X"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a59204c697175696469747920436c61696d65643a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(v4 / 1000000)));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" Y"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72204b72697961204c6f636b64726f703a20"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000)));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v5.buzz, v5.gen_ai, arg8);
    }

    public entry fun infuse_sui_hsui_pool<T0>(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &0x2::clock::Clock, arg2: &HiveChroniclesVault, arg3: &mut 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropVault, arg4: &mut 0x6bd8a0e73fe2dfaa3a2839ea627c5fd1fbc3bbfc37e074abb1ab9f2bb58588a1::two_pool::LiquidityPool<0x2::sui::SUI, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::hsui::HSUI, 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::curves::Curved>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2e9498df0f78cd3fed9eb78a58ab3a622dc43df1332da201bb7d6a12070bbb02::hsui_vault::HSuiVault, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg8: &mut 0xdccda0e1097eb49a7e1fd237fd4f42512af505819dae89b5aa45e4574ee3b38b::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::infuse_sui_hsui_pool(arg1, &arg2.hive_entry_cap, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg2.system_infusion_buzzes, 0x1::string::utf8(b"SUI_HIVESUI_INFUSED"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v1 / 1000000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" SUI and "));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v0 / 1000000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" HSUI added to SUI-hiveSUI Pool!"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a546f74616c205355492d68697665535549204c5020746f6b656e73206b7261667465643a20"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v2 / 1000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" LP"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(x"0a546f74616c204849564520696e63656e746976657320666f72205355492d68697665535549204c6f636b64726f703a20"));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(u64_to_ascii(v3 / 1000000)));
        0x1::string::append(&mut v4.buzz, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg2.hive_entry_cap, arg1, arg7, v4.buzz, v4.gen_ai, arg9);
    }

    public entry fun infuse_usdc<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::deposit_usdc<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, v3, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(b"- [INFUSION-BUZZ] #");
        0x1::string::append(&mut v6, v3);
        0x1::string::append(&mut v6, 0x1::string::utf8(b"  infused "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg5 / 1000000)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" USDC "));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" for `expected` "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" more HIVE GEMS. "));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" Total Expected HIVE GEMS: "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        let v7 = 0x1::string::utf8(b"INFUSE_USDC");
        let v8 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v7);
        0x1::string::append(&mut v6, v8.buzz);
        let v9 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg6);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v9, v7, v6, v8.gen_ai);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_cetus_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg3: &0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0x7edfe97adaa37e238f870276872d88a2e19f7eb0b0b1712748488dabc93b550e::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg8: u64, arg9: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"CETUS_ATTACK_INITIALIZED_FOR_POOL"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020466f7220506f6f6c20496e697469616c697a65642120"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4964656e74696665723a20"));
        0x1::string::append(&mut v0.buzz, arg6);
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4c6f636b64726f7020666f7220506f6f6c20416464726573733a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::initialize_attack_on_cetus_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg10)));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg9, v0.buzz, v0.gen_ai, arg10);
    }

    public entry fun initialize_attack_on_flowx_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg3: &0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg4: &mut 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg7: u64, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"FLOWX_ATTACK_INITIALIZED_FOR_POOL"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020466f7220506f6f6c20496e697469616c697a65642120"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4964656e74696665723a20"));
        0x1::string::append(&mut v0.buzz, arg5);
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4c6f636b64726f7020666f7220506f6f6c20416464726573733a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::initialize_attack_on_flowx_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg9)));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg8, v0.buzz, v0.gen_ai, arg9);
    }

    public entry fun initialize_attack_on_kriya_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg3: &0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropForPool<T1, T2, T3>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T1, T2>, arg5: &mut 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg8: u64, arg9: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"KRIYA_ATTACK_INITIALIZED_FOR_POOL"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020466f7220506f6f6c20496e697469616c697a65642120"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4964656e74696665723a20"));
        0x1::string::append(&mut v0.buzz, arg6);
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4c6f636b64726f7020666f7220506f6f6c20416464726573733a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::initialize_attack_on_kriya_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10)));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg9, v0.buzz, v0.gen_ai, arg10);
    }

    public entry fun initialize_hive_chronicles(arg0: 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg1: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::AdminDofOwnershipCapability, arg3: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::AdminDofOwnershipCapability, arg4: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::AdminDofOwnershipCapability, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun initialize_lockdrop_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg3: &mut 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2e9498df0f78cd3fed9eb78a58ab3a622dc43df1332da201bb7d6a12070bbb02::hsui_vault::HSuiVault, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfileMappingStore, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HSuiDisperser<0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg1.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_FOR_POOL"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020466f7220506f6f6c20496e697469616c697a65642120"));
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4964656e74696665723a20"));
        0x1::string::append(&mut v0.buzz, arg11);
        0x1::string::append(&mut v0.buzz, 0x1::string::utf8(x"0a4c6f636b64726f7020666f7220506f6f6c20416464726573733a20"));
        0x1::string::append(&mut v0.buzz, 0x2::address::to_string(0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::initialize_lockdrop_pool<T1, T2, T3>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12)));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg10, v0.buzz, v0.gen_ai, arg12);
    }

    public entry fun initialize_lockdrops<T0>(arg0: &HiveChroniclesVault, arg1: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg3: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2e9498df0f78cd3fed9eb78a58ab3a622dc43df1332da201bb7d6a12070bbb02::hsui_vault::HSuiVault, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfileMappingStore, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HSuiDisperser<0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd5f4801759346e9e1dca5e81e4128e3cb0c22afa94dd7bc13538e04fd3f098cb::lockdrop::initialize_lockdrops(&arg0.hive_entry_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        let v5 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, 0x1::string::utf8(b"INITIALIZE_LOCKDROP_CONFIGs"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020496e697469616c697a65642120"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a4c6f636b64726f70205661756c7420416464726573733a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v4));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a0a4c6f636b64726f7020436f6e6669677320496e697469616c697a65642120"));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a4c5344204c6f636b64726f70205661756c7420416464726573733a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v0));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a4b726979612041747461636b20436f6e66696720416464726573733a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v1));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a466c6f77582041747461636b20436f6e66696720416464726573733a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v2));
        0x1::string::append(&mut v5.buzz, 0x1::string::utf8(x"0a43657475732041747461636b20436f6e66696720416464726573733a20"));
        0x1::string::append(&mut v5.buzz, 0x2::address::to_string(v3));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg0.hive_entry_cap, arg11, arg10, v5.buzz, v5.gen_ai, arg20);
    }

    public entry fun kraft_hive_profile(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2e9498df0f78cd3fed9eb78a58ab3a622dc43df1332da201bb7d6a12070bbb02::hsui_vault::HSuiVault, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfileMappingStore, arg5: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HSuiDisperser<0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = kraft_new_hive_chronicle(arg10);
        let v1 = *0x1::vector::borrow<0x1::string::String>(&arg0.welcome_buzzes_list, ((0x2::clock::timestamp_ms(arg1) % 0x1::vector::length<0x1::string::String>(&arg0.welcome_buzzes_list)) as u64));
        let v2 = *0x2::linked_table::borrow<0x1::string::String, ChronicleBuzz>(&arg0.welcome_buzzes, v1);
        let v3 = &mut v0;
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), arg8, v3, 0x1::option::none<u64>(), v1, v2.user_log, v2.gen_ai, false, arg10);
        0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::kraft_hive_profile_and_return_sui<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10), 0x2::tx_context::sender(arg10), arg10);
    }

    fun kraft_new_hive_chronicle(arg0: &mut 0x2::tx_context::TxContext) : HiveChronicles {
        HiveChronicles{
            id               : 0x2::object::new(arg0),
            infusion_buzzes  : 0x2::linked_table::new<u64, UserInfusionBuzz>(arg0),
            infusion_count   : 0,
            liquid_hive      : 0,
            vested_hive      : 0,
            chronicle_buzzes : 0x2::linked_table::new<u64, UserChronicleBuzz>(arg0),
            total_logs       : 0,
        }
    }

    public entry fun lock_flowx_lp_tokens<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T1, T2>>, arg6: u64, arg7: u64, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::lock_lp_tokens<T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let v2 = 0x1::string::utf8(u64_to_ascii(arg6 / 1000000000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" LP tokens added to FlowX lockup of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" weeks, for an expected increase of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE rewards!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c206578706563746564204849564520726577617264732076696120466c6f7758204c6f636b64726f703a20"));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg8, v2, 0x1::option::none<0x1::string::String>(), arg9);
    }

    public entry fun lock_kriya_lp_tokens<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T1, T2>, arg6: u64, arg7: u64, arg8: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::lock_lp_tokens<T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let v2 = 0x1::string::utf8(u64_to_ascii(arg6 / 1000000000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" LP tokens added to Kriya lockup of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(arg7)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" weeks, for an expected increase of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE rewards!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c2065787065637465642048495645207265776172647320766961204b72697961204c6f636b64726f703a20"));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg8, v2, 0x1::option::none<0x1::string::String>(), arg9);
    }

    fun make_buzz_for_infusion_rewards_claim(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"- [INFUSION-BUZZ] #");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  claimed rewards and shares for participation in USDC-HIVE Infusion -::- "));
        if (arg3 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a484956452047454d5320636c61696d65642061732070617274696369706174696f6e2072657761726473202d20"));
            0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg3 / 1000000)));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE_GEMS"));
        };
        if (arg2 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a484956452047454d5320636c61696d6564206173207374616b696e672072657761726473202d20"));
            0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg2 / 1000000)));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" HIVE_GEMS"));
        };
        if (arg1 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a555344432d48495645204c5020546f6b656e7320756e626f6e646564202d20"));
            0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg1 / 1000000)));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens"));
        };
        if (arg4 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a555344432d48495645204c5020546f6b656e7320756e6c6f636b6564202d20"));
            0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg4 / 1000000)));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" LP Tokens"));
        };
        if (arg5 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a504f4c20546f6b656e7320636c61696d65642061732072657761726473202d20"));
            0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg5 / 1000000)));
            0x1::string::append(&mut v0, 0x1::string::utf8(b" POL Tokens"));
        };
        if (arg6 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4947454d5320546f6b656e7320636c61696d65642061732070617274696369706174696f6e2072657761726473202d20"));
            0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg6 / 1000000000)));
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

    public entry fun new_add_system_buzz(arg0: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveChroniclesVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun withdraw_flowx_lp_tokens<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxAttackConfig, arg3: &mut 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::FlowxLockdropForPool<T1, T2>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack::withdraw_lp_tokens<T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg8);
        let v2 = 0x1::string::utf8(u64_to_ascii(arg5 / 1000000000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" LP tokens withdrawn from FlowX lockup of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" weeks, for an expected decrease of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE rewards!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c206578706563746564204849564520726577617264732076696120466c6f7758204c6f636b64726f703a20"));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg7, v2, 0x1::option::none<0x1::string::String>(), arg8);
    }

    public entry fun withdraw_from_lsd_lockup_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &mut 0xdccda0e1097eb49a7e1fd237fd4f42512af505819dae89b5aa45e4574ee3b38b::lsd_lockdrop::LsdLockdropVault, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdccda0e1097eb49a7e1fd237fd4f42512af505819dae89b5aa45e4574ee3b38b::lsd_lockdrop::withdraw_from_lsd_lockup_position(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0x1::string::utf8(u64_to_ascii(arg4 / 1000000000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" SUI withdrawn from LSD Lockup of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(arg5)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" weeks, for an expected decrease of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE rewards!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c2065787065637465642048495645207265776172647320766961204c5344204c6f636b64726f703a20"));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg6, v2, 0x1::option::none<0x1::string::String>(), arg7);
    }

    public entry fun withdraw_kriya_lp_tokens<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HiveChroniclesVault, arg2: &0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaAttackConfig, arg3: &mut 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::KriyaLockdropForPool<T1, T2>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HiveVault, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x22cc338391e481a2eea96586123d248538553705da5e2bc028eed886d9148315::kriya_vampire_attack::withdraw_lp_tokens<T1, T2>(arg0, &arg1.hive_entry_cap, arg2, arg3, arg4, arg5, arg6, arg8);
        let v2 = 0x1::string::utf8(u64_to_ascii(arg5 / 1000000000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" LP tokens withdrawn from Kriya lockup of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(arg6)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" weeks, for an expected decrease of "));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE rewards!"));
        0x1::string::append(&mut v2, 0x1::string::utf8(x"0a546f74616c2065787065637465642048495645207265776172647320766961204b72697961204c6f636b64726f703a20"));
        0x1::string::append(&mut v2, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        0x1::string::append(&mut v2, 0x1::string::utf8(b" HIVE"));
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::deploy_hive_stream<T0>(&arg1.hive_entry_cap, arg0, arg7, v2, 0x1::option::none<0x1::string::String>(), arg8);
    }

    public entry fun withdraw_usdc_from_infusion<T0>(arg0: &HiveChroniclesVault, arg1: &0x2::clock::Clock, arg2: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveManager, arg3: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::infusion::handle_withdraw_usdc<T0>(&arg0.infusion_vault_dof_manager_cap, arg1, arg2, arg3, arg4, arg5);
        let (_, v3, _, _) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0x1::string::utf8(b"- [INFUSION-BUZZ] #");
        0x1::string::append(&mut v6, v3);
        0x1::string::append(&mut v6, 0x1::string::utf8(b"  withdrew "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(arg4 / 1000000)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" USDC "));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" for `expected` "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(v0 / 1000000)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" less HIVE GEMS. "));
        0x1::string::append(&mut v6, 0x1::string::utf8(b" Total Expected HIVE GEMS: "));
        0x1::string::append(&mut v6, 0x1::string::utf8(u64_to_ascii(v1 / 1000000)));
        let v7 = 0x1::string::utf8(b"WITHDRAW_USDC");
        let v8 = *0x2::linked_table::borrow<0x1::string::String, InfusionBuzz>(&arg0.system_infusion_buzzes, v7);
        0x1::string::append(&mut v6, v8.buzz);
        let v9 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_borrow_mut_from_profile<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg3, arg5);
        make_new_infusion_buzz(0x2::clock::timestamp_ms(arg1), v3, v9, v7, v6, v8.gen_ai);
    }

    // decompiled from Move bytecode v6
}

