module 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    struct HiveVault has store, key {
        id: 0x2::object::UID,
        dao_hive_profile: 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile,
        gem_kraft_cap: 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::HiveGemKraftCap,
        hive_treasury_cap: 0x2::coin::TreasuryCap<HIVE>,
        active_supply: u64,
    }

    struct KraftHive has copy, drop {
        user: address,
        hive_krafted: u64,
    }

    struct BurnHive has copy, drop {
        user: address,
        hive_burnt: u64,
    }

    public fun burn_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile, arg2: 0x2::balance::Balance<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        let v0 = BurnHive{
            user       : 0x2::tx_context::sender(arg4),
            hive_burnt : arg3,
        };
        0x2::event::emit<BurnHive>(v0);
        arg0.active_supply = arg0.active_supply - arg3;
        0x2::coin::burn<HIVE>(&mut arg0.hive_treasury_cap, 0x2::coin::from_balance<HIVE>(0x2::balance::split<HIVE>(&mut arg2, arg3), arg4));
        0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::transfer_hive_gems(&mut arg0.dao_hive_profile, arg1, arg3, arg4);
        arg2
    }

    public fun burn_hive_and_return_gems(arg0: &mut HiveVault, arg1: 0x2::balance::Balance<HIVE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<HIVE>, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::HiveGems) {
        let v0 = BurnHive{
            user       : 0x2::tx_context::sender(arg3),
            hive_burnt : arg2,
        };
        0x2::event::emit<BurnHive>(v0);
        arg0.active_supply = arg0.active_supply - arg2;
        0x2::coin::burn<HIVE>(&mut arg0.hive_treasury_cap, 0x2::coin::from_balance<HIVE>(0x2::balance::split<HIVE>(&mut arg1, arg2), arg3));
        (arg1, 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::withdraw_gems_from_profile(&mut arg0.dao_hive_profile, arg2))
    }

    public entry fun burn_hive_for_gems(arg0: &mut HiveVault, arg1: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile, arg2: 0x2::coin::Coin<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_hive_and_return(arg0, arg1, 0x2::coin::into_balance<HIVE>(arg2), arg3, arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<HIVE>(v0, v1, arg4);
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveVault, arg1: &mut 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::HiveGems, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_gems_for_hive_and_return(arg0, arg1, arg2, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        destroy_or_transfer_balance<HIVE>(v0, v1, arg3);
    }

    public fun deposit_gems_for_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::HiveGems, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::deposit_gems_in_profile(&mut arg0.dao_hive_profile, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::split(arg1, arg2));
        kraft_hive(arg0, arg2, 0x2::tx_context::sender(arg3))
    }

    public entry fun deposit_gems_via_profile(arg0: &mut HiveVault, arg1: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_gems_via_profile_and_return(arg0, arg1, arg2, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        destroy_or_transfer_balance<HIVE>(v0, v1, arg3);
    }

    public fun deposit_gems_via_profile_and_return(arg0: &mut HiveVault, arg1: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::transfer_hive_gems(arg1, &mut arg0.dao_hive_profile, arg2, arg3);
        kraft_hive(arg0, arg2, 0x2::tx_context::sender(arg3))
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_active_hive_supply(arg0: &HiveVault) : u64 {
        arg0.active_supply
    }

    public fun get_dao_hiveprofile_info(arg0: &HiveVault) : (0x1::string::String, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::get_profile_info(&arg0.dao_hive_profile)
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"HIVE", b"HIVE is the Governance and in-game currency for degenhive's programmable-identity (HiveProfile) driven open-ecosystem.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_hive_vault(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xa802cf597dfc88a5f3408fb2ab4b9bc5e09e9e38f44bc3aec157a419f40e09f8::hsui_vault::HSuiVault, arg2: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfileMappingStore, arg3: &0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::config::DexDaoCapability, arg4: 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::HiveGemKraftCap, arg5: 0x2::coin::TreasuryCap<HIVE>, arg6: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfileConfig, arg7: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HSuiDisperser<0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hsui::HSUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::kraft_hive_gems(&mut arg4, 100000000000000);
        0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::deposit_gems_for_distribution_via_cards(&arg4, arg6, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::split(&mut v0, 7000000000000));
        let (v1, v2) = 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::kraft_owned_hive_profile(arg0, arg1, arg2, arg6, arg7, arg8, 0x1::string::utf8(b"HiveVault"), 0, 0, 0, arg9);
        let v3 = HiveVault{
            id                : 0x2::object::new(arg9),
            dao_hive_profile  : v1,
            gem_kraft_cap     : arg4,
            hive_treasury_cap : arg5,
            active_supply     : 0,
        };
        0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::config::kraft_treasury_for_hive<HIVE>(arg3, arg9);
        let v4 = &mut v3;
        let v5 = &mut v0;
        let v6 = deposit_gems_for_hive_and_return(v4, v5, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&v0), arg9);
        0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::destroy_zero(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIVE>>(0x2::coin::from_balance<HIVE>(v6, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::share_object<HiveVault>(v3);
    }

    fun kraft_hive(arg0: &mut HiveVault, arg1: u64, arg2: address) : 0x2::balance::Balance<HIVE> {
        let v0 = KraftHive{
            user         : arg2,
            hive_krafted : arg1,
        };
        0x2::event::emit<KraftHive>(v0);
        arg0.active_supply = arg0.active_supply + arg1;
        0x2::coin::mint_balance<HIVE>(&mut arg0.hive_treasury_cap, arg1)
    }

    // decompiled from Move bytecode v6
}

