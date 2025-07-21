module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land {
    struct LandStaked has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct LandUnstakeInitiated has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        cooldown_duration_ms: u64,
    }

    struct LandWithdrawn has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct LandCooldownCancelled has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct StorageStaked has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct StorageUnstakeInitiated has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        cooldown_duration_ms: u64,
    }

    struct StorageWithdrawn has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct ResourcesProduced has copy, drop {
        user: address,
        resources: vector<0x1::string::String>,
        amounts: vector<0x1::string::String>,
    }

    struct RaffleStarted has copy, drop {
        user: address,
        roll: u128,
    }

    struct WonRareResource has copy, drop {
        user: address,
        resource: 0x1::string::String,
        amount: u64,
        roll: u128,
    }

    struct UserRegistered has copy, drop {
        user: address,
    }

    struct AdminUpdated has copy, drop {
        new_admin: address,
    }

    struct TreasuryUpdated has copy, drop {
        new_treasury: address,
    }

    struct VersionUpdated has copy, drop {
        admin: address,
        old_version: u64,
        new_version: u64,
    }

    struct ItemStaked has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        item_type: u8,
        item_name: 0x1::string::String,
    }

    struct ItemUnstakeInitiated has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        item_type: u8,
        item_name: 0x1::string::String,
        cooldown_duration_ms: u64,
    }

    struct ItemWithdrawn has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        item_type: u8,
        item_name: 0x1::string::String,
    }

    struct PAWTATO_LAND has drop {
        dummy_field: bool,
    }

    struct LandAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResourceAmounts has copy, drop {
        wood: u128,
        stone: u128,
        water: u128,
        coal: u128,
        iron: u128,
        gold: u128,
        crystal: u128,
    }

    struct LandInfo has drop, store {
        nft_id: 0x2::object::ID,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
    }

    struct LandInfoDto has copy, drop, store {
        nft_id: 0x2::object::ID,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
    }

    struct UserLandInfo has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
    }

    struct ItemInfo has drop, store {
        nft_id: 0x2::object::ID,
        item_type: u8,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
    }

    struct ItemInfoDto has copy, drop, store {
        nft_id: 0x2::object::ID,
        item_type: u8,
        item_name: 0x1::string::String,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
    }

    struct StorageInfoDto has copy, drop, store {
        nft_id: 0x2::object::ID,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        lands: vector<LandInfo>,
        items: vector<ItemInfo>,
        last_claim_ts: u64,
        last_raffle_ts: u64,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        admin_address: address,
        treasury_address: address,
        users: 0x2::table::Table<address, UserInfo>,
        stakers: vector<address>,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
        version: u64,
        paused: bool,
    }

    struct LandTraitCacheKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UserDashboardInfo has copy, drop {
        storage_caps: ResourceAmounts,
        production_rate_per_second: ResourceAmounts,
        claimable_resources: ResourceAmounts,
        staked_lands: vector<LandInfoDto>,
        total_lands_count: u64,
        active_lands_count: u64,
        cooldown_lands_count: u64,
        staked_items: vector<ItemInfoDto>,
        last_claim_ts: u64,
        last_raffle_ts: u64,
        cooldown_duration_ms: u64,
        raffle_interval_ms: u64,
    }

    public entry fun add_durability_to_all_staked_tools(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        check_not_paused(arg1);
        let v0 = 10;
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1.stakers) && v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg1.stakers, v1);
            if (0x2::table::contains<address, UserInfo>(&arg1.users, v3)) {
                let v4 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.users, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<ItemInfo>(&v4.items) && v2 < v0) {
                    let v6 = 0x1::vector::borrow<ItemInfo>(&v4.items, v5);
                    if (v6.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_storage()) {
                        let v7 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg1.kiosk, &arg1.kiosk_owner_cap, v6.nft_id);
                        let v8 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_durability_string(v7);
                        if (0x1::option::is_none<0x1::string::String>(&v8)) {
                            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::add_durability_if_missing(v7);
                            v2 = v2 + 1;
                        };
                    };
                    v5 = v5 + 1;
                };
            };
            v1 = v1 + 1;
        };
    }

    fun add_staker(arg0: &mut StakingPool, arg1: address) {
        let v0 = &mut arg0.stakers;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg1) {
                return
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<address>(v0, arg1);
    }

    fun auto_claim_resources(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ResourceAmounts {
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, v0)) {
            return ResourceAmounts{
                wood    : 0,
                stone   : 0,
                water   : 0,
                coal    : 0,
                iron    : 0,
                gold    : 0,
                crystal : 0,
            }
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0);
        if (arg2 <= v1.last_claim_ts) {
            return ResourceAmounts{
                wood    : 0,
                stone   : 0,
                water   : 0,
                coal    : 0,
                iron    : 0,
                gold    : 0,
                crystal : 0,
            }
        };
        let v2 = compute_user_production_with_storage_boost_by_address(arg0, v0, arg2 - v1.last_claim_ts);
        0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0).last_claim_ts = arg2;
        mint_resources(arg0, arg1, v2, arg3);
        v2
    }

    fun calculate_max_storage_caps(arg0: u128) : ResourceAmounts {
        ResourceAmounts{
            wood    : 1000000000 * arg0,
            stone   : 1000000000 * arg0,
            water   : 1000000000 * arg0,
            coal    : 300000000 * arg0,
            iron    : 300000000 * arg0,
            gold    : 100000000 * arg0,
            crystal : 50000000 * arg0,
        }
    }

    fun calculate_max_storage_caps_with_boost(arg0: u128, arg1: u128) : ResourceAmounts {
        let v0 = calculate_max_storage_caps(arg0);
        ResourceAmounts{
            wood    : v0.wood * arg1 / 10000,
            stone   : v0.stone * arg1 / 10000,
            water   : v0.water * arg1 / 10000,
            coal    : v0.coal * arg1 / 10000,
            iron    : v0.iron * arg1 / 10000,
            gold    : v0.gold * arg1 / 10000,
            crystal : v0.crystal * arg1 / 10000,
        }
    }

    public entry fun cancel_land_cooldown(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        auto_claim_resources(arg0, arg2, v0, arg4);
        let v1 = get_user(arg0, arg4);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<LandInfo>(&v1.lands)) {
            let v4 = 0x1::vector::borrow_mut<LandInfo>(&mut v1.lands, v2);
            if (v4.nft_id == arg1) {
                assert!(0x1::option::is_some<u64>(&v4.cooldown_ts), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_unstaked());
                v4.cooldown_ts = 0x1::option::none<u64>();
                v4.stake_ts = v0;
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_found());
        let v5 = LandCooldownCancelled{
            user   : 0x2::tx_context::sender(arg4),
            nft_id : arg1,
        };
        0x2::event::emit<LandCooldownCancelled>(v5);
    }

    public fun check_not_paused(arg0: &StakingPool) {
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
    }

    public fun check_version(arg0: &StakingPool) {
        assert!(arg0.version == 2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim_resources(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        auto_claim_resources(arg0, arg1, v0, arg4);
        maybe_raffle(arg0, arg1, v0, arg3, arg4);
    }

    fun compute_single_land_production(arg0: &StakingPool, arg1: &LandInfo, arg2: u64, arg3: &0x1::option::Option<vector<u8>>) : ResourceAmounts {
        if (0x1::option::is_some<u64>(&arg1.cooldown_ts)) {
            return ResourceAmounts{
                wood    : 0,
                stone   : 0,
                water   : 0,
                coal    : 0,
                iron    : 0,
                gold    : 0,
                crystal : 0,
            }
        };
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = if (0x1::option::is_some<vector<u8>>(arg3)) {
            let v9 = 0x1::option::borrow<vector<u8>>(arg3);
            (get_cached_size_multiplier(v9, 0), get_cached_size_multiplier(v9, 1), get_cached_size_multiplier(v9, 2), get_cached_size_multiplier(v9, 3), get_cached_size_multiplier(v9, 4), get_cached_size_multiplier(v9, 5), get_cached_size_multiplier(v9, 6), get_cached_sky_bonus(v9), get_cached_soil_bonus(v9))
        } else {
            let v10 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg1.nft_id));
            let v11 = 0x1::string::utf8(b"None");
            let v12 = 0x1::string::utf8(b"Mint");
            let v13 = 0x1::string::utf8(b"Brown");
            let v14 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Wood");
            let v15 = get_attribute_or_default(v10, &v14, &v11);
            let v16 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Stone");
            let v17 = get_attribute_or_default(v10, &v16, &v11);
            let v18 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Water");
            let v19 = get_attribute_or_default(v10, &v18, &v11);
            let v20 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Coal");
            let v21 = get_attribute_or_default(v10, &v20, &v11);
            let v22 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Iron");
            let v23 = get_attribute_or_default(v10, &v22, &v11);
            let v24 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Gold");
            let v25 = get_attribute_or_default(v10, &v24, &v11);
            let v26 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Crystal");
            let v27 = get_attribute_or_default(v10, &v26, &v11);
            let v28 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Sky");
            let v29 = get_attribute_or_default(v10, &v28, &v12);
            let v30 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Soil");
            let v31 = get_attribute_or_default(v10, &v30, &v13);
            (size_enum_to_multiplier(string_to_size_enum_u8(&v15)), size_enum_to_multiplier(string_to_size_enum_u8(&v17)), size_enum_to_multiplier(string_to_size_enum_u8(&v19)), size_enum_to_multiplier(string_to_size_enum_u8(&v21)), size_enum_to_multiplier(string_to_size_enum_u8(&v23)), size_enum_to_multiplier(string_to_size_enum_u8(&v25)), size_enum_to_multiplier(string_to_size_enum_u8(&v27)), sky_enum_to_bonus(string_to_sky_enum_u8(&v29)), soil_enum_to_bonus(string_to_soil_enum_u8(&v31)))
        };
        let v32 = 10000 + v7 + v8;
        let v33 = ((arg2 / 1000) as u128);
        ResourceAmounts{
            wood    : v33 * 14000 * v0 * v32 / 10000,
            stone   : v33 * 14000 * v1 * v32 / 10000,
            water   : v33 * 14000 * v2 * v32 / 10000,
            coal    : v33 * 4200 * v3 * v32 / 10000,
            iron    : v33 * 4200 * v4 * v32 / 10000,
            gold    : v33 * 840 * v5 * v32 / 10000,
            crystal : v33 * 560 * v6 * v32 / 10000,
        }
    }

    fun compute_user_production_with_storage_boost_by_address(arg0: &mut StakingPool, arg1: address, arg2: u64) : ResourceAmounts {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return ResourceAmounts{
                wood    : 0,
                stone   : 0,
                water   : 0,
                coal    : 0,
                iron    : 0,
                gold    : 0,
                crystal : 0,
            }
        };
        let v0 = ResourceAmounts{
            wood    : 0,
            stone   : 0,
            water   : 0,
            coal    : 0,
            iron    : 0,
            gold    : 0,
            crystal : 0,
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v2 = 0x1::vector::length<LandInfo>(&v1.lands);
        if (v2 == 0) {
            return v0
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            if (0x1::option::is_none<u64>(&0x1::vector::borrow<LandInfo>(&v1.lands, v4).cooldown_ts)) {
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        if (v3 == 0) {
            return v0
        };
        let v5 = 0;
        while (v5 < v2) {
            let v6 = 0x1::vector::borrow<LandInfo>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).lands, v5);
            let v7 = LandInfo{
                nft_id      : v6.nft_id,
                stake_ts    : v6.stake_ts,
                cooldown_ts : v6.cooldown_ts,
            };
            if (0x1::option::is_none<u64>(&v6.cooldown_ts)) {
                let v8 = get_or_cache_land_traits(arg0, &v7);
                let v9 = 0x1::option::some<vector<u8>>(v8);
                let v10 = compute_single_land_production(arg0, &v7, arg2, &v9);
                if (v10.wood > 0) {
                    v0.wood = v0.wood + v10.wood;
                };
                if (v10.stone > 0) {
                    v0.stone = v0.stone + v10.stone;
                };
                if (v10.water > 0) {
                    v0.water = v0.water + v10.water;
                };
                if (v10.coal > 0) {
                    v0.coal = v0.coal + v10.coal;
                };
                if (v10.iron > 0) {
                    v0.iron = v0.iron + v10.iron;
                };
                if (v10.gold > 0) {
                    v0.gold = v0.gold + v10.gold;
                };
                if (v10.crystal > 0) {
                    v0.crystal = v0.crystal + v10.crystal;
                };
            };
            v5 = v5 + 1;
        };
        let v11 = get_storage_boost_from_staked_items(arg0, &0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).items);
        let v12 = calculate_max_storage_caps_with_boost((v3 as u128), v11);
        if (v0.wood > v12.wood) {
            v0.wood = v12.wood;
        };
        if (v0.stone > v12.stone) {
            v0.stone = v12.stone;
        };
        if (v0.water > v12.water) {
            v0.water = v12.water;
        };
        if (v0.coal > v12.coal) {
            v0.coal = v12.coal;
        };
        if (v0.iron > v12.iron) {
            v0.iron = v12.iron;
        };
        if (v0.gold > v12.gold) {
            v0.gold = v12.gold;
        };
        if (v0.crystal > v12.crystal) {
            v0.crystal = v12.crystal;
        };
        v0
    }

    fun compute_user_production_with_storage_boost_readonly(arg0: &StakingPool, arg1: &vector<LandInfo>, arg2: &vector<ItemInfo>, arg3: u64) : ResourceAmounts {
        let v0 = ResourceAmounts{
            wood    : 0,
            stone   : 0,
            water   : 0,
            coal    : 0,
            iron    : 0,
            gold    : 0,
            crystal : 0,
        };
        let v1 = 0x1::vector::length<LandInfo>(arg1);
        if (v1 == 0) {
            return v0
        };
        if (arg3 < 1000) {
            return v0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            if (0x1::option::is_none<u64>(&0x1::vector::borrow<LandInfo>(arg1, v3).cooldown_ts)) {
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        if (v2 == 0) {
            return v0
        };
        let v4 = calculate_max_storage_caps_with_boost((v2 as u128), get_storage_boost_from_staked_items(arg0, arg2));
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            let v7 = 0x1::vector::borrow<LandInfo>(arg1, v6);
            if (0x1::option::is_none<u64>(&v7.cooldown_ts)) {
                v5 = v5 + 1;
                let v8 = 0x1::option::none<vector<u8>>();
                let v9 = compute_single_land_production(arg0, v7, arg3, &v8);
                if (v9.wood > 0) {
                    v0.wood = v0.wood + v9.wood;
                };
                if (v9.stone > 0) {
                    v0.stone = v0.stone + v9.stone;
                };
                if (v9.water > 0) {
                    v0.water = v0.water + v9.water;
                };
                if (v9.coal > 0) {
                    v0.coal = v0.coal + v9.coal;
                };
                if (v9.iron > 0) {
                    v0.iron = v0.iron + v9.iron;
                };
                if (v9.gold > 0) {
                    v0.gold = v0.gold + v9.gold;
                };
                if (v9.crystal > 0) {
                    v0.crystal = v0.crystal + v9.crystal;
                };
            };
            v6 = v6 + 1;
        };
        if (v0.wood > v4.wood) {
            v0.wood = v4.wood;
        };
        if (v0.stone > v4.stone) {
            v0.stone = v4.stone;
        };
        if (v0.water > v4.water) {
            v0.water = v4.water;
        };
        if (v0.coal > v4.coal) {
            v0.coal = v4.coal;
        };
        if (v0.iron > v4.iron) {
            v0.iron = v4.iron;
        };
        if (v0.gold > v4.gold) {
            v0.gold = v4.gold;
        };
        if (v0.crystal > v4.crystal) {
            v0.crystal = v4.crystal;
        };
        v0
    }

    fun count_items_by_type(arg0: &vector<ItemInfo>, arg1: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<ItemInfo>(arg0)) {
            if (0x1::vector::borrow<ItemInfo>(arg0, v1).item_type == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun find_land_for_withdraw(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = get_user(arg0, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<LandInfo>(&v0.lands)) {
            let v2 = 0x1::vector::borrow<LandInfo>(&v0.lands, v1);
            if (v2.nft_id == arg1) {
                assert!(0x1::option::is_some<u64>(&v2.cooldown_ts), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_unstaked());
                assert!(arg2 >= *0x1::option::borrow<u64>(&v2.cooldown_ts), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_cooldown_not_over());
                return v1
            };
            v1 = v1 + 1;
        };
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_found()
    }

    public fun get_active_item_count(arg0: &StakingPool, arg1: address, arg2: u8) : u64 {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<ItemInfo>(&v0.items)) {
            let v3 = 0x1::vector::borrow<ItemInfo>(&v0.items, v2);
            if (v3.item_type == arg2 && 0x1::option::is_none<u64>(&v3.cooldown_ts)) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_all_staked_lands(arg0: &StakingPool) : vector<UserLandInfo> {
        let v0 = 0x1::vector::empty<UserLandInfo>();
        let v1 = &arg0.stakers;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            if (0x2::table::contains<address, UserInfo>(&arg0.users, v3)) {
                let v4 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<LandInfo>(&v4.lands)) {
                    let v6 = 0x1::vector::borrow<LandInfo>(&v4.lands, v5);
                    let v7 = UserLandInfo{
                        user        : v3,
                        nft_id      : v6.nft_id,
                        stake_ts    : v6.stake_ts,
                        cooldown_ts : v6.cooldown_ts,
                    };
                    0x1::vector::push_back<UserLandInfo>(&mut v0, v7);
                    v5 = v5 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun get_attribute_or_default(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &0x1::string::String, arg2: &0x1::string::String) : 0x1::string::String {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, arg1)) {
            *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, arg1)
        } else {
            *arg2
        }
    }

    fun get_cached_size_multiplier(arg0: &vector<u8>, arg1: u64) : u128 {
        size_enum_to_multiplier(*0x1::vector::borrow<u8>(arg0, arg1))
    }

    fun get_cached_sky_bonus(arg0: &vector<u8>) : u128 {
        sky_enum_to_bonus(*0x1::vector::borrow<u8>(arg0, 7))
    }

    fun get_cached_soil_bonus(arg0: &vector<u8>) : u128 {
        soil_enum_to_bonus(*0x1::vector::borrow<u8>(arg0, 8))
    }

    fun get_lands_without_cooldown_count(arg0: &vector<LandInfo>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<LandInfo>(arg0)) {
            if (0x1::option::is_none<u64>(&0x1::vector::borrow<LandInfo>(arg0, v1).cooldown_ts)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_or_cache_land_traits(arg0: &mut StakingPool, arg1: &LandInfo) : vector<u8> {
        let v0 = arg1.nft_id;
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<0x2::object::ID, vector<u8>>(&arg0.id, v0)
        } else {
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, v0));
            let v3 = 0x1::string::utf8(b"None");
            let v4 = 0x1::string::utf8(b"Mint");
            let v5 = 0x1::string::utf8(b"Brown");
            let v6 = 0x1::vector::empty<u8>();
            let v7 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Wood");
            let v8 = get_attribute_or_default(v2, &v7, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v8));
            let v9 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Stone");
            let v10 = get_attribute_or_default(v2, &v9, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v10));
            let v11 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Water");
            let v12 = get_attribute_or_default(v2, &v11, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v12));
            let v13 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Coal");
            let v14 = get_attribute_or_default(v2, &v13, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v14));
            let v15 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Iron");
            let v16 = get_attribute_or_default(v2, &v15, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v16));
            let v17 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Gold");
            let v18 = get_attribute_or_default(v2, &v17, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v18));
            let v19 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Crystal");
            let v20 = get_attribute_or_default(v2, &v19, &v3);
            0x1::vector::push_back<u8>(&mut v6, string_to_size_enum_u8(&v20));
            let v21 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Sky");
            let v22 = get_attribute_or_default(v2, &v21, &v4);
            0x1::vector::push_back<u8>(&mut v6, string_to_sky_enum_u8(&v22));
            let v23 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Soil");
            let v24 = get_attribute_or_default(v2, &v23, &v5);
            0x1::vector::push_back<u8>(&mut v6, string_to_soil_enum_u8(&v24));
            0x2::dynamic_field::add<0x2::object::ID, vector<u8>>(&mut arg0.id, v0, v6);
            *0x2::dynamic_field::borrow<0x2::object::ID, vector<u8>>(&arg0.id, v0)
        }
    }

    fun get_or_create_user(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : &mut UserInfo {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, v0)) {
            let v1 = UserInfo{
                id             : 0x2::object::new(arg2),
                lands          : 0x1::vector::empty<LandInfo>(),
                items          : 0x1::vector::empty<ItemInfo>(),
                last_claim_ts  : arg1,
                last_raffle_ts : 0,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.users, v0, v1);
            add_staker(arg0, v0);
            let v2 = UserRegistered{user: v0};
            0x2::event::emit<UserRegistered>(v2);
        };
        0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0)
    }

    public fun get_staked_item_count(arg0: &StakingPool, arg1: address, arg2: u8) : u64 {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        count_items_by_type(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).items, arg2)
    }

    public fun get_staked_items(arg0: &StakingPool, arg1: address) : vector<ItemInfoDto> {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0x1::vector::empty<ItemInfoDto>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<ItemInfo>(&v0.items)) {
            let v3 = 0x1::vector::borrow<ItemInfo>(&v0.items, v2);
            let v4 = ItemInfoDto{
                nft_id      : v3.nft_id,
                item_type   : v3.item_type,
                item_name   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(v3.item_type),
                stake_ts    : v3.stake_ts,
                cooldown_ts : v3.cooldown_ts,
            };
            0x1::vector::push_back<ItemInfoDto>(&mut v1, v4);
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_staked_items_by_type(arg0: &StakingPool, arg1: address, arg2: u8) : vector<ItemInfoDto> {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0x1::vector::empty<ItemInfoDto>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<ItemInfo>(&v0.items)) {
            let v3 = 0x1::vector::borrow<ItemInfo>(&v0.items, v2);
            if (v3.item_type == arg2) {
                let v4 = ItemInfoDto{
                    nft_id      : v3.nft_id,
                    item_type   : v3.item_type,
                    item_name   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(v3.item_type),
                    stake_ts    : v3.stake_ts,
                    cooldown_ts : v3.cooldown_ts,
                };
                0x1::vector::push_back<ItemInfoDto>(&mut v1, v4);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_staked_lands(arg0: &StakingPool, arg1: address) : vector<LandInfoDto> {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = &0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).lands;
        let v1 = 0x1::vector::empty<LandInfoDto>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<LandInfo>(v0)) {
            let v3 = 0x1::vector::borrow<LandInfo>(v0, v2);
            let v4 = LandInfoDto{
                nft_id      : v3.nft_id,
                stake_ts    : v3.stake_ts,
                cooldown_ts : v3.cooldown_ts,
            };
            0x1::vector::push_back<LandInfoDto>(&mut v1, v4);
            v2 = v2 + 1;
        };
        v1
    }

    fun get_storage_boost_from_staked_items(arg0: &StakingPool, arg1: &vector<ItemInfo>) : u128 {
        let v0 = 10000;
        let v1 = v0;
        let v2 = 0x1::vector::length<ItemInfo>(arg1);
        if (v2 == 0) {
            return v0
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::borrow<ItemInfo>(arg1, v3);
            if (v4.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_storage() && 0x1::option::is_none<u64>(&v4.cooldown_ts)) {
                v1 = (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_storage_multiplier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&arg0.kiosk, &arg0.kiosk_owner_cap, v4.nft_id)) as u128);
            };
            v3 = v3 + 1;
        };
        v1
    }

    fun get_user(arg0: &mut StakingPool, arg1: &0x2::tx_context::TxContext) : &mut UserInfo {
        0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, 0x2::tx_context::sender(arg1))
    }

    public fun get_user_claimable_resources(arg0: &StakingPool, arg1: address, arg2: &0x2::clock::Clock) : ResourceAmounts {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 <= v0.last_claim_ts) {
            return ResourceAmounts{
                wood    : 0,
                stone   : 0,
                water   : 0,
                coal    : 0,
                iron    : 0,
                gold    : 0,
                crystal : 0,
            }
        };
        compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, v1 - v0.last_claim_ts)
    }

    public fun get_user_dashboard_info(arg0: &StakingPool, arg1: address, arg2: &0x2::clock::Clock) : UserDashboardInfo {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x1::vector::length<LandInfo>(&v0.lands);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            if (0x1::option::is_none<u64>(&0x1::vector::borrow<LandInfo>(&v0.lands, v5).cooldown_ts)) {
                v3 = v3 + 1;
            } else {
                v4 = v4 + 1;
            };
            v5 = v5 + 1;
        };
        let v6 = if (v3 > 0) {
            compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, 1000)
        } else {
            ResourceAmounts{wood: 0, stone: 0, water: 0, coal: 0, iron: 0, gold: 0, crystal: 0}
        };
        let v7 = if (v1 > v0.last_claim_ts) {
            compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, v1 - v0.last_claim_ts)
        } else {
            ResourceAmounts{wood: 0, stone: 0, water: 0, coal: 0, iron: 0, gold: 0, crystal: 0}
        };
        UserDashboardInfo{
            storage_caps               : calculate_max_storage_caps_with_boost((v3 as u128), get_storage_boost_from_staked_items(arg0, &v0.items)),
            production_rate_per_second : v6,
            claimable_resources        : v7,
            staked_lands               : get_staked_lands(arg0, arg1),
            total_lands_count          : v2,
            active_lands_count         : v3,
            cooldown_lands_count       : v4,
            staked_items               : get_staked_items(arg0, arg1),
            last_claim_ts              : v0.last_claim_ts,
            last_raffle_ts             : v0.last_raffle_ts,
            cooldown_duration_ms       : 259200000,
            raffle_interval_ms         : 86400000,
        }
    }

    public fun get_user_production_rate_per_second(arg0: &StakingPool, arg1: address) : ResourceAmounts {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, 1000)
    }

    public fun get_user_storage_caps(arg0: &StakingPool, arg1: address) : ResourceAmounts {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<LandInfo>(&v0.lands)) {
            if (0x1::option::is_none<u64>(&0x1::vector::borrow<LandInfo>(&v0.lands, v2).cooldown_ts)) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        calculate_max_storage_caps_with_boost(v1, get_storage_boost_from_staked_items(arg0, &v0.items))
    }

    public fun has_item_staked(arg0: &StakingPool, arg1: address, arg2: u8) : bool {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        count_items_by_type(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).items, arg2) > 0
    }

    fun init(arg0: PAWTATO_LAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LandAdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = StakingPool{
            id               : 0x2::object::new(arg1),
            admin_address    : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            treasury_address : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            users            : 0x2::table::new<address, UserInfo>(arg1),
            stakers          : 0x1::vector::empty<address>(),
            kiosk            : v1,
            kiosk_owner_cap  : v2,
            version          : 2,
            paused           : false,
        };
        0x2::transfer::transfer<LandAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_LAND>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingPool>(v3);
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LandAdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = StakingPool{
            id               : 0x2::object::new(arg1),
            admin_address    : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            treasury_address : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            users            : 0x2::table::new<address, UserInfo>(arg1),
            stakers          : 0x1::vector::empty<address>(),
            kiosk            : v1,
            kiosk_owner_cap  : v2,
            version          : 2,
            paused           : false,
        };
        0x2::transfer::transfer<LandAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingPool>(v3);
    }

    fun maybe_raffle(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user(arg0, arg2, arg4);
        if (arg2 < v0.last_raffle_ts + 86400000) {
            return
        };
        let v1 = get_lands_without_cooldown_count(&v0.lands);
        v0.last_raffle_ts = arg2;
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = 0x2::random::generate_u128(&mut v2) % 1000000;
        let v4 = RaffleStarted{
            user : 0x2::tx_context::sender(arg4),
            roll : v3,
        };
        0x2::event::emit<RaffleStarted>(v4);
        if (v3 < 17 * v1) {
            let v5 = 1 * 1000000000;
            mint_resource(arg0, arg1, 11, v5, arg4);
            let v6 = WonRareResource{
                user     : 0x2::tx_context::sender(arg4),
                resource : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(),
                amount   : (v5 as u64),
                roll     : v3,
            };
            0x2::event::emit<WonRareResource>(v6);
            let v7 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v7, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>());
            let v8 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v8, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(v5));
            let v9 = ResourcesProduced{
                user      : 0x2::tx_context::sender(arg4),
                resources : v7,
                amounts   : v8,
            };
            0x2::event::emit<ResourcesProduced>(v9);
        } else if (v3 < (17 + 270) * v1) {
            let v10 = 1 * 1000000000;
            mint_resource(arg0, arg1, 12, v10, arg4);
            let v11 = WonRareResource{
                user     : 0x2::tx_context::sender(arg4),
                resource : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(),
                amount   : (v10 as u64),
                roll     : v3,
            };
            0x2::event::emit<WonRareResource>(v11);
            let v12 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v12, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>());
            let v13 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v13, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(v10));
            let v14 = ResourcesProduced{
                user      : 0x2::tx_context::sender(arg4),
                resources : v12,
                amounts   : v13,
            };
            0x2::event::emit<ResourcesProduced>(v14);
        } else if (v3 < (17 + 270 + 270) * v1) {
            let v15 = 1 * 1000000000;
            mint_resource(arg0, arg1, 10, v15, arg4);
            let v16 = WonRareResource{
                user     : 0x2::tx_context::sender(arg4),
                resource : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>(),
                amount   : (v15 as u64),
                roll     : v3,
            };
            0x2::event::emit<WonRareResource>(v16);
            let v17 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v17, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>());
            let v18 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v18, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(v15));
            let v19 = ResourcesProduced{
                user      : 0x2::tx_context::sender(arg4),
                resources : v17,
                amounts   : v18,
            };
            0x2::event::emit<ResourcesProduced>(v19);
        };
    }

    fun mint_resource(arg0: &StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u8, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 18446744073709551615, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_amount_too_large());
        assert!(arg3 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_amount_too_small());
        if (arg2 == 1) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_wood_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_wood_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 2) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_stone_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_stone_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 3) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_water_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_water_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 4) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_coal_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coal_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 5) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_iron_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_iron_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 6) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_iron_bar_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_iron_bar_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 7) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_gold_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_gold_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 8) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_gold_bar_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_gold_bar_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 9) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_crystal_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_crystal_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 10) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_chaos_seed_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_chaos_seed_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 11) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_phoenix_feather_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_phoenix_feather_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        } else if (arg2 == 12) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_titanium_splinter_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_titanium_splinter_new(arg1, 0x2::object::id<StakingPool>(arg0), (arg3 as u64), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun mint_resources(arg0: &StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: ResourceAmounts, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2.wood == 0) {
            if (arg2.stone == 0) {
                if (arg2.water == 0) {
                    if (arg2.coal == 0) {
                        if (arg2.iron == 0) {
                            if (arg2.gold == 0) {
                                arg2.crystal == 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        if (arg2.wood > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.wood));
            mint_resource(arg0, arg1, 1, arg2.wood, arg3);
        };
        if (arg2.stone > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.stone));
            mint_resource(arg0, arg1, 2, arg2.stone, arg3);
        };
        if (arg2.water > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.water));
            mint_resource(arg0, arg1, 3, arg2.water, arg3);
        };
        if (arg2.coal > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.coal));
            mint_resource(arg0, arg1, 4, arg2.coal, arg3);
        };
        if (arg2.iron > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.iron));
            mint_resource(arg0, arg1, 5, arg2.iron, arg3);
        };
        if (arg2.gold > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.gold));
            mint_resource(arg0, arg1, 7, arg2.gold, arg3);
        };
        if (arg2.crystal > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string_with_0x<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>());
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u128_to_string(arg2.crystal));
            mint_resource(arg0, arg1, 9, arg2.crystal, arg3);
        };
        if (!0x1::vector::is_empty<0x1::string::String>(&v2)) {
            let v4 = ResourcesProduced{
                user      : v1,
                resources : v2,
                amounts   : v3,
            };
            0x2::event::emit<ResourcesProduced>(v4);
        };
    }

    fun remove_land_from_user(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_user(arg0, arg2);
        0x1::vector::remove<LandInfo>(&mut v0.lands, arg1);
        if (!user_has_staked_nfts(v0)) {
            remove_staker(arg0, 0x2::tx_context::sender(arg2));
        };
    }

    fun remove_staker(arg0: &mut StakingPool, arg1: address) {
        let v0 = &mut arg0.stakers;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg1) {
                0x1::vector::remove<address>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public entry fun set_paused(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        arg1.paused = arg2;
    }

    fun size_enum_to_multiplier(arg0: u8) : u128 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            3
        } else if (arg0 == 3) {
            5
        } else {
            0
        }
    }

    fun sky_enum_to_bonus(arg0: u8) : u128 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            500
        } else if (arg0 == 2) {
            1000
        } else if (arg0 == 3) {
            1500
        } else if (arg0 == 4) {
            2000
        } else if (arg0 == 5) {
            2500
        } else if (arg0 == 6) {
            5000
        } else if (arg0 == 7) {
            10000
        } else {
            0
        }
    }

    fun soil_enum_to_bonus(arg0: u8) : u128 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            1000
        } else if (arg0 == 2) {
            2000
        } else if (arg0 == 3) {
            3000
        } else if (arg0 == 4) {
            7500
        } else {
            0
        }
    }

    public entry fun stake_land(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        auto_claim_resources(arg0, arg5, v0, arg7);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::kiosk_helpers::direct_transfer<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(arg1, arg2, &mut arg0.kiosk, &arg0.kiosk_owner_cap, arg3, arg4, arg7);
        let v2 = LandInfo{
            nft_id      : arg3,
            stake_ts    : v0,
            cooldown_ts : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<LandInfo>(&mut get_or_create_user(arg0, v0, arg7).lands, v2);
        let v3 = LandStaked{
            user   : v1,
            nft_id : arg3,
        };
        0x2::event::emit<LandStaked>(v3);
    }

    public entry fun stake_tool(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        auto_claim_resources(arg0, arg5, v0, arg7);
        let v2 = 0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg3);
        let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(v2);
        let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_durability_string(v2);
        if (0x1::option::is_none<0x1::string::String>(&v4)) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::add_durability_if_missing(0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, arg3));
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::kiosk_helpers::direct_transfer<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, &mut arg0.kiosk, &arg0.kiosk_owner_cap, arg3, arg4, arg7);
        let v5 = get_or_create_user(arg0, v0, arg7);
        let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_limit(v3);
        if (v6 > 0) {
            assert!(count_items_by_type(&v5.items, v3) < v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_staked_item_limit_reached());
        };
        let v7 = ItemInfo{
            nft_id      : arg3,
            item_type   : v3,
            stake_ts    : v0,
            cooldown_ts : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<ItemInfo>(&mut v5.items, v7);
        let v8 = ItemStaked{
            user      : v1,
            nft_id    : arg3,
            item_type : v3,
            item_name : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(v3),
        };
        0x2::event::emit<ItemStaked>(v8);
    }

    fun string_to_size_enum_u8(arg0: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) == 0) {
            return 0
        };
        let v1 = *0x1::vector::borrow<u8>(v0, 0);
        if (v1 == 83) {
            1
        } else if (v1 == 77) {
            2
        } else if (v1 == 76) {
            3
        } else {
            0
        }
    }

    fun string_to_sky_enum_u8(arg0: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) == 0) {
            return 0
        };
        let v1 = *0x1::vector::borrow<u8>(v0, 0);
        if (v1 == 77) {
            0
        } else if (v1 == 67) {
            1
        } else if (v1 == 76) {
            2
        } else if (v1 == 71) {
            3
        } else if (v1 == 83) {
            if (0x1::vector::length<u8>(v0) > 1) {
                if (*0x1::vector::borrow<u8>(v0, 1) == 117) {
                    if (0x1::vector::length<u8>(v0) > 2) {
                        if (*0x1::vector::borrow<u8>(v0, 2) == 110) {
                            if (0x1::vector::length<u8>(v0) > 3) {
                                if (*0x1::vector::borrow<u8>(v0, 3) == 114) {
                                    4
                                } else {
                                    6
                                }
                            } else {
                                4
                            }
                        } else {
                            4
                        }
                    } else {
                        4
                    }
                } else {
                    4
                }
            } else {
                4
            }
        } else if (v1 == 68) {
            5
        } else if (v1 == 65) {
            7
        } else {
            0
        }
    }

    fun string_to_soil_enum_u8(arg0: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) == 0) {
            return 0
        };
        let v1 = *0x1::vector::borrow<u8>(v0, 0);
        if (v1 == 66) {
            0
        } else if (v1 == 79) {
            if (0x1::vector::length<u8>(v0) > 1) {
                if (*0x1::vector::borrow<u8>(v0, 1) == 99) {
                    1
                } else {
                    3
                }
            } else {
                1
            }
        } else if (v1 == 84) {
            2
        } else if (v1 == 86) {
            4
        } else {
            0
        }
    }

    public entry fun unstake_item(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        auto_claim_resources(arg0, arg2, v0, arg4);
        let v2 = get_user(arg0, arg4);
        let v3 = 0x1::option::none<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<ItemInfo>(&v2.items)) {
            let v5 = 0x1::vector::borrow<ItemInfo>(&v2.items, v4);
            if (v5.nft_id == arg1) {
                assert!(0x1::option::is_none<u64>(&v5.cooldown_ts), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_already_in_cooldown());
                v3 = 0x1::option::some<u64>(v4);
                break
            };
            v4 = v4 + 1;
        };
        assert!(0x1::option::is_some<u64>(&v3), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_nft_not_found());
        let v6 = 0x1::vector::borrow_mut<ItemInfo>(&mut v2.items, *0x1::option::borrow<u64>(&v3));
        v6.cooldown_ts = 0x1::option::some<u64>(v0 + 259200000);
        let v7 = ItemUnstakeInitiated{
            user                 : v1,
            nft_id               : v6.nft_id,
            item_type            : v6.item_type,
            item_name            : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(v6.item_type),
            cooldown_duration_ms : 259200000,
        };
        0x2::event::emit<ItemUnstakeInitiated>(v7);
    }

    public entry fun unstake_land(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        auto_claim_resources(arg0, arg2, v0, arg4);
        let v2 = get_user(arg0, arg4);
        let v3 = 0;
        while (v3 < 0x1::vector::length<LandInfo>(&v2.lands)) {
            let v4 = 0x1::vector::borrow_mut<LandInfo>(&mut v2.lands, v3);
            if (v4.nft_id == arg1) {
                assert!(0x1::option::is_none<u64>(&v4.cooldown_ts), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_unstaking());
                v4.cooldown_ts = 0x1::option::some<u64>(v0 + 259200000);
                let v5 = LandUnstakeInitiated{
                    user                 : v1,
                    nft_id               : arg1,
                    cooldown_duration_ms : 259200000,
                };
                0x2::event::emit<LandUnstakeInitiated>(v5);
                return
            };
            v3 = v3 + 1;
        };
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_found()
    }

    public entry fun update_admin_address(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        check_not_paused(arg1);
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun update_treasury_address(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        check_not_paused(arg1);
        arg1.treasury_address = arg2;
        let v0 = TreasuryUpdated{new_treasury: arg2};
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public entry fun upgrade_version(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.version;
        assert!(v0 < 2, 13906836356186767359);
        arg1.version = 2;
        let v1 = VersionUpdated{
            admin       : 0x2::tx_context::sender(arg2),
            old_version : v0,
            new_version : 2,
        };
        0x2::event::emit<VersionUpdated>(v1);
    }

    fun user_has_staked_nfts(arg0: &UserInfo) : bool {
        !0x1::vector::is_empty<LandInfo>(&arg0.lands) || !0x1::vector::is_empty<ItemInfo>(&arg0.items)
    }

    public entry fun withdraw_item<T0: store + key>(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        auto_claim_resources(arg0, arg5, 0x2::clock::timestamp_ms(arg6), arg7);
        let v1 = get_user(arg0, arg7);
        let v2 = 0x1::option::none<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<ItemInfo>(&v1.items)) {
            if (0x1::vector::borrow<ItemInfo>(&v1.items, v3).nft_id == arg3) {
                v2 = 0x1::option::some<u64>(v3);
                break
            };
            v3 = v3 + 1;
        };
        assert!(0x1::option::is_some<u64>(&v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_nft_not_found());
        let v4 = 0x1::vector::remove<ItemInfo>(&mut v1.items, *0x1::option::borrow<u64>(&v2));
        if (!user_has_staked_nfts(v1)) {
            remove_staker(arg0, v0);
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::kiosk_helpers::direct_transfer<T0>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg1, arg2, arg3, arg4, arg7);
        let v5 = ItemWithdrawn{
            user      : v0,
            nft_id    : arg3,
            item_type : v4.item_type,
            item_name : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(v4.item_type),
        };
        0x2::event::emit<ItemWithdrawn>(v5);
    }

    public entry fun withdraw_land(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        auto_claim_resources(arg0, arg5, v0, arg7);
        let v2 = find_land_for_withdraw(arg0, arg3, v0, arg7);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::kiosk_helpers::direct_transfer<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg1, arg2, arg3, arg4, arg7);
        remove_land_from_user(arg0, v2, arg7);
        let v3 = LandWithdrawn{
            user   : v1,
            nft_id : arg3,
        };
        0x2::event::emit<LandWithdrawn>(v3);
    }

    // decompiled from Move bytecode v7
}

