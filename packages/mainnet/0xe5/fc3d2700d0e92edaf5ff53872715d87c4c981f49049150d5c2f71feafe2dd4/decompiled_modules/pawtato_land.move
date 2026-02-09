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

    struct DebugEvent has copy, drop {
        messages: vector<0x1::string::String>,
    }

    struct GildedPrismConsumed has copy, drop {
        user: address,
        boost_expires_at: u64,
        level: u8,
    }

    struct MaterialConsumed has copy, drop {
        user: address,
        material: 0x1::string::String,
        boost_expires_at: u64,
        level: u8,
    }

    struct GildedPrismBoost has drop, store {
        expires_at: u64,
        level: u8,
    }

    struct PrimalLoamBoost has drop, store {
        expires_at: u64,
        level: u8,
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

    struct SlotUpgraded has copy, drop {
        user: address,
        category: u8,
        new_level: u8,
        resource: 0x1::string::String,
        cost: u64,
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

    struct UserSlotUpgrades has store {
        category_upgrades: vector<u8>,
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

    struct RepresentingLandUnset has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    public entry fun add_durability_to_all_staked_tools(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun add_durability_to_all_staked_tools_batched(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
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

    fun address_to_dyn_key(arg0: address, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<address>(&arg0));
        arg1
    }

    fun address_to_gilded_prism_key(arg0: address) : vector<u8> {
        address_to_dyn_key(arg0, b"gilded_prism_boost")
    }

    fun address_to_primal_loam_key(arg0: address) : vector<u8> {
        address_to_dyn_key(arg0, b"primal_loam_boost")
    }

    fun address_to_rep_land_key(arg0: address) : vector<u8> {
        address_to_dyn_key(arg0, b"representing_land")
    }

    fun auto_claim_resources(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ResourceAmounts {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun calculate_durability_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * 1 + arg1 * 3 + arg2 * 5;
        let v1 = if (v0 < 10) {
            10
        } else {
            v0
        };
        v1 / 10
    }

    fun calculate_max_storage_with_land_types_readonly(arg0: &StakingPool, arg1: &vector<LandInfo>, arg2: u128) : ResourceAmounts {
        let v0 = ResourceAmounts{
            wood    : 0,
            stone   : 0,
            water   : 0,
            coal    : 0,
            iron    : 0,
            gold    : 0,
            crystal : 0,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<LandInfo>(arg1)) {
            let v2 = 0x1::vector::borrow<LandInfo>(arg1, v1);
            if (0x1::option::is_none<u64>(&v2.cooldown_ts)) {
                let v3 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
                let v4 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Plot");
                let v5 = get_attribute_or_default(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, v2.nft_id)), &v3, &v4);
                let v6 = land_type_enum_to_storage_mul(string_to_land_type_enum_u8(&v5));
                v0.wood = v0.wood + 1000000000 * v6 / 10000;
                v0.stone = v0.stone + 1000000000 * v6 / 10000;
                v0.water = v0.water + 1000000000 * v6 / 10000;
                v0.coal = v0.coal + 300000000 * v6 / 10000;
                v0.iron = v0.iron + 300000000 * v6 / 10000;
                v0.gold = v0.gold + 100000000 * v6 / 10000;
                v0.crystal = v0.crystal + 50000000 * v6 / 10000;
            };
            v1 = v1 + 1;
        };
        ResourceAmounts{
            wood    : v0.wood * arg2 / 10000,
            stone   : v0.stone * arg2 / 10000,
            water   : v0.water * arg2 / 10000,
            coal    : v0.coal * arg2 / 10000,
            iron    : v0.iron * arg2 / 10000,
            gold    : v0.gold * arg2 / 10000,
            crystal : v0.crystal * arg2 / 10000,
        }
    }

    fun calculate_user_storage_caps_with_land_types(arg0: &mut StakingPool, arg1: address, arg2: u64) : ResourceAmounts {
        let v0 = get_tool_boost(arg0, &0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).items, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg2);
        let v1 = ResourceAmounts{
            wood    : 0,
            stone   : 0,
            water   : 0,
            coal    : 0,
            iron    : 0,
            gold    : 0,
            crystal : 0,
        };
        let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<LandInfo>(&v2.lands)) {
            let v5 = 0x1::vector::borrow<LandInfo>(&v2.lands, v4);
            if (0x1::option::is_none<u64>(&v5.cooldown_ts)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v5.nft_id);
            };
            v4 = v4 + 1;
        };
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            let v7 = get_or_cache_land_traits(arg0, *0x1::vector::borrow<0x2::object::ID>(&v3, v6));
            let v8 = get_cached_land_type_storage_mult(&v7);
            v1.wood = v1.wood + 1000000000 * v8 / 10000;
            v1.stone = v1.stone + 1000000000 * v8 / 10000;
            v1.water = v1.water + 1000000000 * v8 / 10000;
            v1.coal = v1.coal + 300000000 * v8 / 10000;
            v1.iron = v1.iron + 300000000 * v8 / 10000;
            v1.gold = v1.gold + 100000000 * v8 / 10000;
            v1.crystal = v1.crystal + 50000000 * v8 / 10000;
            v6 = v6 + 1;
        };
        ResourceAmounts{
            wood    : v1.wood * v0 / 10000,
            stone   : v1.stone * v0 / 10000,
            water   : v1.water * v0 / 10000,
            coal    : v1.coal * v0 / 10000,
            iron    : v1.iron * v0 / 10000,
            gold    : v1.gold * v0 / 10000,
            crystal : v1.crystal * v0 / 10000,
        }
    }

    public entry fun cancel_land_cooldown(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun check_not_paused(arg0: &StakingPool) {
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
    }

    public fun check_version(arg0: &StakingPool) {
        assert!(arg0.version == 11, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim_resources(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun clear_item_cooldown_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: address, arg3: 0x2::object::ID) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun compute_single_land_production(arg0: &StakingPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x1::option::Option<vector<u8>>) : ResourceAmounts {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = if (0x1::option::is_some<vector<u8>>(arg3)) {
            let v10 = 0x1::option::borrow<vector<u8>>(arg3);
            (get_cached_size_multiplier(v10, 0), get_cached_size_multiplier(v10, 1), get_cached_size_multiplier(v10, 2), get_cached_size_multiplier(v10, 3), get_cached_size_multiplier(v10, 4), get_cached_size_multiplier(v10, 5), get_cached_size_multiplier(v10, 6), get_cached_sky_bonus(v10), get_cached_soil_bonus(v10), get_cached_land_type_production_mul(v10))
        } else {
            let v11 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg1));
            let v12 = 0x1::string::utf8(b"None");
            let v13 = 0x1::string::utf8(b"Mint");
            let v14 = 0x1::string::utf8(b"Brown");
            let v15 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Wood");
            let v16 = get_attribute_or_default(v11, &v15, &v12);
            let v17 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Stone");
            let v18 = get_attribute_or_default(v11, &v17, &v12);
            let v19 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Water");
            let v20 = get_attribute_or_default(v11, &v19, &v12);
            let v21 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Coal");
            let v22 = get_attribute_or_default(v11, &v21, &v12);
            let v23 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Iron");
            let v24 = get_attribute_or_default(v11, &v23, &v12);
            let v25 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Gold");
            let v26 = get_attribute_or_default(v11, &v25, &v12);
            let v27 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Crystal");
            let v28 = get_attribute_or_default(v11, &v27, &v12);
            let v29 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Sky");
            let v30 = get_attribute_or_default(v11, &v29, &v13);
            let v31 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Soil");
            let v32 = get_attribute_or_default(v11, &v31, &v14);
            let v33 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
            let v34 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Plot");
            let v35 = get_attribute_or_default(v11, &v33, &v34);
            (size_enum_to_multiplier(string_to_size_enum_u8(&v16)), size_enum_to_multiplier(string_to_size_enum_u8(&v18)), size_enum_to_multiplier(string_to_size_enum_u8(&v20)), size_enum_to_multiplier(string_to_size_enum_u8(&v22)), size_enum_to_multiplier(string_to_size_enum_u8(&v24)), size_enum_to_multiplier(string_to_size_enum_u8(&v26)), size_enum_to_multiplier(string_to_size_enum_u8(&v28)), sky_enum_to_bonus(string_to_sky_enum_u8(&v30)), soil_enum_to_bonus(string_to_soil_enum_u8(&v32)), land_type_enum_to_production_mul(string_to_land_type_enum_u8(&v35)))
        };
        let v36 = 10000 + v7 + v8;
        let v37 = ((arg2 / 1000) as u128);
        ResourceAmounts{
            wood    : v37 * 14000 * v0 * v36 * v9 / 10000 / 10000,
            stone   : v37 * 14000 * v1 * v36 * v9 / 10000 / 10000,
            water   : v37 * 14000 * v2 * v36 * v9 / 10000 / 10000,
            coal    : v37 * 4200 * v3 * v36 * v9 / 10000 / 10000,
            iron    : v37 * 4200 * v4 * v36 * v9 / 10000 / 10000,
            gold    : v37 * 840 * v5 * v36 * v9 / 10000 / 10000,
            crystal : v37 * 560 * v6 * v36 * v9 / 10000 / 10000,
        }
    }

    fun compute_user_production_with_storage_boost_readonly(arg0: &StakingPool, arg1: &vector<LandInfo>, arg2: &vector<ItemInfo>, arg3: u64, arg4: address, arg5: u64) : ResourceAmounts {
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
        let v4 = get_tool_boost(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe(), arg5);
        let v5 = get_tool_boost(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket(), arg5);
        let v6 = get_tool_boost(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe(), arg5);
        let v7 = get_tool_boost(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), arg5);
        let v8 = calculate_max_storage_with_land_types_readonly(arg0, arg1, get_tool_boost(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg5));
        let v9 = 0;
        let v10 = 0;
        while (v10 < v1) {
            let v11 = 0x1::vector::borrow<LandInfo>(arg1, v10);
            if (0x1::option::is_none<u64>(&v11.cooldown_ts)) {
                v9 = v9 + 1;
                let v12 = 0x1::option::none<vector<u8>>();
                let v13 = compute_single_land_production(arg0, v11.nft_id, arg3, &v12);
                if (v13.wood > 0) {
                    v0.wood = v0.wood + v13.wood;
                };
                if (v13.stone > 0) {
                    v0.stone = v0.stone + v13.stone;
                };
                if (v13.water > 0) {
                    v0.water = v0.water + v13.water;
                };
                if (v13.coal > 0) {
                    v0.coal = v0.coal + v13.coal;
                };
                if (v13.iron > 0) {
                    v0.iron = v0.iron + v13.iron;
                };
                if (v13.gold > 0) {
                    v0.gold = v0.gold + v13.gold;
                };
                if (v13.crystal > 0) {
                    v0.crystal = v0.crystal + v13.crystal;
                };
            };
            v10 = v10 + 1;
        };
        if (v4 > 10000) {
            v0.wood = v0.wood * v4 / 10000;
        };
        if (v5 > 10000) {
            v0.water = v0.water * v5 / 10000;
        };
        if (v6 > 10000) {
            v0.stone = v0.stone * v6 / 10000;
            v0.coal = v0.coal * v6 / 10000;
            v0.iron = v0.iron * v6 / 10000;
            v0.gold = v0.gold * v6 / 10000;
        };
        if (v7 > 10000) {
            v0.crystal = v0.crystal * v7 / 10000;
        };
        let v14 = get_primal_loam_boost(arg0, arg4, arg5);
        if (v14 > 10000) {
            v0.wood = v0.wood * v14 / 10000;
            v0.stone = v0.stone * v14 / 10000;
            v0.water = v0.water * v14 / 10000;
            v0.coal = v0.coal * v14 / 10000;
            v0.iron = v0.iron * v14 / 10000;
            v0.gold = v0.gold * v14 / 10000;
            v0.crystal = v0.crystal * v14 / 10000;
        };
        if (v0.wood > v8.wood) {
            v0.wood = v8.wood;
        };
        if (v0.stone > v8.stone) {
            v0.stone = v8.stone;
        };
        if (v0.water > v8.water) {
            v0.water = v8.water;
        };
        if (v0.coal > v8.coal) {
            v0.coal = v8.coal;
        };
        if (v0.iron > v8.iron) {
            v0.iron = v8.iron;
        };
        if (v0.gold > v8.gold) {
            v0.gold = v8.gold;
        };
        if (v0.crystal > v8.crystal) {
            v0.crystal = v8.crystal;
        };
        v0
    }

    public entry fun consume_gilded_prism(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism::PAWTATO_COIN_GILDED_PRISM>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun consume_primal_loam(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam::PAWTATO_COIN_PRIMAL_LOAM>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public(friend) fun consume_tool_durability(arg0: &mut StakingPool, arg1: address, arg2: 0x2::object::ID, arg3: u64) : bool {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::consume_durability(0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg2), arg3)
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

    fun count_staked_lands_by_type(arg0: &mut StakingPool, arg1: address) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<LandInfo>(&v3.lands)) {
            let v6 = 0x1::vector::borrow<LandInfo>(&v3.lands, v5);
            if (0x1::option::is_none<u64>(&v6.cooldown_ts)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v4, v6.nft_id);
            };
            v5 = v5 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let v8 = get_or_cache_land_traits(arg0, *0x1::vector::borrow<0x2::object::ID>(&v4, v7));
            let v9 = get_cached_land_type(&v8);
            if (v9 == 0) {
                v0 = v0 + 1;
            } else if (v9 == 1) {
                v1 = v1 + 1;
            } else if (v9 == 2) {
                v2 = v2 + 1;
            };
            v7 = v7 + 1;
        };
        (v0, v1, v2)
    }

    public fun get_active_item_count(arg0: &StakingPool, arg1: address, arg2: u8) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
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

    fun get_cached_land_type(arg0: &vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(arg0, 9)
    }

    fun get_cached_land_type_production_mul(arg0: &vector<u8>) : u128 {
        land_type_enum_to_production_mul(get_cached_land_type(arg0))
    }

    fun get_cached_land_type_storage_mult(arg0: &vector<u8>) : u128 {
        land_type_enum_to_storage_mul(get_cached_land_type(arg0))
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

    fun get_gilded_prism_boost(arg0: &StakingPool, arg1: address, arg2: u64) : (u128, u128) {
        if (has_active_gilded_prism_boost(arg0, arg1, arg2)) {
            (1000, 10000)
        } else {
            (0, 0)
        }
    }

    public(friend) fun get_item_info_cooldown_ts(arg0: &ItemInfoDto) : 0x1::option::Option<u64> {
        arg0.cooldown_ts
    }

    public fun get_item_info_nft_id(arg0: &ItemInfoDto) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun get_next_land_token_id(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NFTCollection) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_function_not_ready()
    }

    fun get_or_cache_land_traits(arg0: &mut StakingPool, arg1: 0x2::object::ID) : vector<u8> {
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow<0x2::object::ID, vector<u8>>(&arg0.id, arg1);
            if (0x1::vector::length<u8>(v1) > 9) {
                *v1
            } else {
                let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, vector<u8>>(&mut arg0.id, arg1);
                let v3 = 0x1::string::utf8(b"Plot");
                let v4 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
                let v5 = get_attribute_or_default(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg1)), &v4, &v3);
                0x1::vector::push_back<u8>(v2, string_to_land_type_enum_u8(&v5));
                *v2
            }
        } else {
            let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg1));
            let v7 = 0x1::string::utf8(b"None");
            let v8 = 0x1::string::utf8(b"Mint");
            let v9 = 0x1::string::utf8(b"Brown");
            let v10 = 0x1::string::utf8(b"Plot");
            let v11 = 0x1::vector::empty<u8>();
            let v12 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Wood");
            let v13 = get_attribute_or_default(v6, &v12, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v13));
            let v14 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Stone");
            let v15 = get_attribute_or_default(v6, &v14, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v15));
            let v16 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Water");
            let v17 = get_attribute_or_default(v6, &v16, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v17));
            let v18 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Coal");
            let v19 = get_attribute_or_default(v6, &v18, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v19));
            let v20 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Iron");
            let v21 = get_attribute_or_default(v6, &v20, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v21));
            let v22 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Gold");
            let v23 = get_attribute_or_default(v6, &v22, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v23));
            let v24 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Crystal");
            let v25 = get_attribute_or_default(v6, &v24, &v7);
            0x1::vector::push_back<u8>(&mut v11, string_to_size_enum_u8(&v25));
            let v26 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Sky");
            let v27 = get_attribute_or_default(v6, &v26, &v8);
            0x1::vector::push_back<u8>(&mut v11, string_to_sky_enum_u8(&v27));
            let v28 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Soil");
            let v29 = get_attribute_or_default(v6, &v28, &v9);
            0x1::vector::push_back<u8>(&mut v11, string_to_soil_enum_u8(&v29));
            let v30 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
            let v31 = get_attribute_or_default(v6, &v30, &v10);
            0x1::vector::push_back<u8>(&mut v11, string_to_land_type_enum_u8(&v31));
            0x2::dynamic_field::add<0x2::object::ID, vector<u8>>(&mut arg0.id, arg1, v11);
            *0x2::dynamic_field::borrow<0x2::object::ID, vector<u8>>(&arg0.id, arg1)
        }
    }

    fun get_or_create_slot_upgrades_table(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) : &mut 0x2::table::Table<address, UserSlotUpgrades> {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"slot_upgrades_v1")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, UserSlotUpgrades>>(&mut arg0.id, b"slot_upgrades_v1", 0x2::table::new<address, UserSlotUpgrades>(arg1));
        };
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, UserSlotUpgrades>>(&mut arg0.id, b"slot_upgrades_v1")
    }

    fun get_plot_lands_without_cooldown_count(arg0: &StakingPool, arg1: &vector<LandInfo>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<LandInfo>(arg1)) {
            let v2 = 0x1::vector::borrow<LandInfo>(arg1, v1);
            if (0x1::option::is_none<u64>(&v2.cooldown_ts)) {
                let v3 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
                let v4 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Plot");
                if (get_attribute_or_default(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, v2.nft_id)), &v3, &v4) == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Plot")) {
                    v0 = v0 + 1;
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_primal_loam_boost(arg0: &StakingPool, arg1: address, arg2: u64) : u128 {
        if (has_active_primal_loam_boost(arg0, arg1, arg2)) {
            10000 + 5000
        } else {
            10000
        }
    }

    public fun get_rep_land_id(arg0: &StakingPool, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        let v0 = address_to_rep_land_key(arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg0.id, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
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

    public fun get_staked_land(arg0: &StakingPool, arg1: address, arg2: 0x2::object::ID) : &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<LandInfo>(&v0.lands)) {
            if (0x1::vector::borrow<LandInfo>(&v0.lands, v1).nft_id == arg2) {
                return 0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg2)
            };
            v1 = v1 + 1;
        };
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_found()
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

    public fun get_staked_tool_for_upgrading_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: address, arg3: 0x2::object::ID) : &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun get_tool_boost(arg0: &StakingPool, arg1: &vector<ItemInfo>, arg2: u8, arg3: u64) : u128 {
        let v0 = if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel()) {
            0
        } else {
            10000
        };
        let v1 = 0x1::vector::length<ItemInfo>(arg1);
        if (v1 == 0) {
            return v0
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<ItemInfo>(arg1, v2);
            if (v3.item_type == arg2) {
                if (v3.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma() || v3.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel() || is_item_active(v3, arg3)) {
                    if (v3.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow()) {
                        return (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_storage_multiplier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&arg0.kiosk, &arg0.kiosk_owner_cap, v3.nft_id)) as u128)
                    };
                    if (v3.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma()) {
                        return (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_idol_raffle_multiplier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&arg0.kiosk, &arg0.kiosk_owner_cap, v3.nft_id)) as u128)
                    };
                    if (v3.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel()) {
                        return (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_shovel_urr_chance(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&arg0.kiosk, &arg0.kiosk_owner_cap, v3.nft_id)) as u128)
                    };
                    return (0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_prod_mul(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&arg0.kiosk, &arg0.kiosk_owner_cap, v3.nft_id)) as u128)
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun get_upgrade_cost_and_coin_type(arg0: u8, arg1: u8) : (u64, u64) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun get_urr_interval(arg0: address) : u64 {
        if (is_test_user(arg0)) {
            86400000 / 24
        } else {
            86400000
        }
    }

    fun get_user_category_upgrade_level(arg0: &StakingPool, arg1: address, arg2: u8) : u8 {
        if (slot_upgrades_table_exists(arg0)) {
            let v1 = 0x2::dynamic_field::borrow<vector<u8>, 0x2::table::Table<address, UserSlotUpgrades>>(&arg0.id, b"slot_upgrades_v1");
            if (0x2::table::contains<address, UserSlotUpgrades>(v1, arg1)) {
                let v2 = 0x2::table::borrow<address, UserSlotUpgrades>(v1, arg1);
                let v3 = (arg2 as u64);
                if (v3 < 0x1::vector::length<u8>(&v2.category_upgrades)) {
                    *0x1::vector::borrow<u8>(&v2.category_upgrades, v3)
                } else {
                    0
                }
            } else {
                0
            }
        } else {
            0
        }
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
        compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, v1 - v0.last_claim_ts, arg1, v1)
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
            compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, 1000, arg1, v1)
        } else {
            ResourceAmounts{wood: 0, stone: 0, water: 0, coal: 0, iron: 0, gold: 0, crystal: 0}
        };
        let v7 = if (v1 > v0.last_claim_ts) {
            compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, v1 - v0.last_claim_ts, arg1, v1)
        } else {
            ResourceAmounts{wood: 0, stone: 0, water: 0, coal: 0, iron: 0, gold: 0, crystal: 0}
        };
        UserDashboardInfo{
            storage_caps               : calculate_max_storage_with_land_types_readonly(arg0, &v0.lands, get_tool_boost(arg0, &v0.items, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), v1)),
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
            raffle_interval_ms         : get_urr_interval(arg1),
        }
    }

    public fun get_user_production_rate_per_second(arg0: &StakingPool, arg1: address) : ResourceAmounts {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_user_production_rate_per_second_v2(arg0: &StakingPool, arg1: address, arg2: &0x2::clock::Clock) : ResourceAmounts {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        compute_user_production_with_storage_boost_readonly(arg0, &v0.lands, &v0.items, 1000, arg1, 0x2::clock::timestamp_ms(arg2))
    }

    public fun get_user_slots(arg0: &StakingPool, arg1: address) : vector<u8> {
        if (slot_upgrades_table_exists(arg0)) {
            let v1 = 0x2::dynamic_field::borrow<vector<u8>, 0x2::table::Table<address, UserSlotUpgrades>>(&arg0.id, b"slot_upgrades_v1");
            if (0x2::table::contains<address, UserSlotUpgrades>(v1, arg1)) {
                0x2::table::borrow<address, UserSlotUpgrades>(v1, arg1).category_upgrades
            } else {
                0x1::vector::empty<u8>()
            }
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_user_storage_caps(arg0: &StakingPool, arg1: address) : ResourceAmounts {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_user_urr_probabilities(arg0: &StakingPool, arg1: address, arg2: &0x2::clock::Clock) : vector<u128> {
        let v0 = vector[];
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            0x1::vector::push_back<u128>(&mut v0, 0);
            0x1::vector::push_back<u128>(&mut v0, 0);
            0x1::vector::push_back<u128>(&mut v0, 0);
            0x1::vector::push_back<u128>(&mut v0, 0);
            0x1::vector::push_back<u128>(&mut v0, 0);
            return v0
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v3 = get_plot_lands_without_cooldown_count(arg0, &v2.lands);
        let v4 = get_tool_boost(arg0, &v2.items, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), v1);
        let v5 = get_tool_boost(arg0, &v2.items, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel(), v1);
        let (v6, v7) = get_gilded_prism_boost(arg0, arg1, v1);
        let v8 = if (v5 > 0) {
            v7 / 4
        } else {
            v7 / 2
        };
        let v9 = v8 * 10000;
        let v10 = if (v5 > 0) {
            v5 * v3 * v4 / 10000 / 2
        } else {
            0
        };
        0x1::vector::push_back<u128>(&mut v0, (17 * v3 * v4 + v6 * 10000) / 10000);
        0x1::vector::push_back<u128>(&mut v0, (270 * v3 * v4 + v9) / 10000);
        0x1::vector::push_back<u128>(&mut v0, (270 * v3 * v4 + v9) / 10000);
        0x1::vector::push_back<u128>(&mut v0, v10);
        0x1::vector::push_back<u128>(&mut v0, v10);
        v0
    }

    fun has_active_gilded_prism_boost(arg0: &StakingPool, arg1: address, arg2: u64) : bool {
        let v0 = address_to_gilded_prism_key(arg1);
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0) && arg2 < 0x2::dynamic_field::borrow<vector<u8>, GildedPrismBoost>(&arg0.id, v0).expires_at
    }

    fun has_active_primal_loam_boost(arg0: &StakingPool, arg1: address, arg2: u64) : bool {
        let v0 = address_to_primal_loam_key(arg1);
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0) && arg2 < 0x2::dynamic_field::borrow<vector<u8>, PrimalLoamBoost>(&arg0.id, v0).expires_at
    }

    public fun has_item_staked(arg0: &StakingPool, arg1: address, arg2: u8) : bool {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return false
        };
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
            version          : 11,
            paused           : false,
        };
        0x2::transfer::transfer<LandAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_LAND>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingPool>(v3);
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun is_item_active(arg0: &ItemInfo, arg1: u64) : bool {
        0x1::option::is_none<u64>(&arg0.cooldown_ts) || arg1 >= *0x1::option::borrow<u64>(&arg0.cooldown_ts)
    }

    fun is_test_user(arg0: address) : bool {
        arg0 == @0x30fa04a11a6e96e34e5a9fb16d126ee6481b8bb65cfbf45c8959d9c56b38abd3 || arg0 == @0xbff7d619bc376d09745addd8d252461cddad51e73b5259100744117f4cba4b15
    }

    fun land_type_enum_to_production_mul(arg0: u8) : u128 {
        if (arg0 == 0) {
            10000
        } else if (arg0 == 1) {
            20000
        } else if (arg0 == 2) {
            30000
        } else {
            10000
        }
    }

    fun land_type_enum_to_storage_mul(arg0: u8) : u128 {
        if (arg0 == 0) {
            10000
        } else if (arg0 == 1) {
            40000
        } else if (arg0 == 2) {
            90000
        } else {
            10000
        }
    }

    fun maybe_raffle(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun migrate_user_lands_to_kiosk(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::AdminCap, arg1: &mut StakingPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg5: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(0x2::table::contains<address, UserInfo>(&arg1.users, arg6), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_user_not_found());
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.users, arg6);
        let v1 = 0x1::vector::length<LandInfo>(&v0.lands);
        assert!(v1 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_land_not_found());
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < v1 && v3 < 100) {
            let v4 = v1 - 1 - v3;
            let v5 = 0x1::vector::borrow<LandInfo>(&v0.lands, v4).nft_id;
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::direct_transfer_v2<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&mut arg1.kiosk, &arg1.kiosk_owner_cap, arg2, arg3, v5, arg4, arg5, arg7);
            0x1::vector::remove<LandInfo>(&mut v0.lands, v4);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v5);
            v3 = v3 + 1;
        };
        v2
    }

    public fun mint_merged_land(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NFTCollection, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_function_not_ready()
    }

    fun mint_resource(arg0: &StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u8, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun mint_resources(arg0: &StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: ResourceAmounts, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun rebuild_stakers_vector(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
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

    public fun set_item_cooldown_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: address, arg3: 0x2::object::ID, arg4: u64) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun set_land_attribute_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun set_land_influence(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: 0x2::object::ID, arg3: u64) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_function_not_ready()
    }

    public entry fun set_paused(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        arg1.paused = arg2;
    }

    public fun set_rep_land(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: address, arg3: 0x2::object::ID) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
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

    fun slot_upgrades_table_exists(arg0: &StakingPool) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"slot_upgrades_v1")
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
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun stake_land_after_merge(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: address, arg5: 0x2::object::ID, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_function_not_ready()
    }

    public entry fun stake_tool(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun string_to_land_type_enum_u8(arg0: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) == 0) {
            return 0
        };
        let v1 = *0x1::vector::borrow<u8>(v0, 0);
        if (v1 == 80) {
            if (0x1::vector::length<u8>(v0) > 1) {
                if (*0x1::vector::borrow<u8>(v0, 1) == 108) {
                    0
                } else {
                    2
                }
            } else {
                0
            }
        } else if (v1 == 69) {
            1
        } else {
            0
        }
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

    public entry fun unlock_advanced_blacksmithing(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun unlock_advanced_masonry(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun unlock_advanced_woodworking(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun unlock_basic_masonry_slot_2<T0>(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun unlock_basic_woodworking_slot_2<T0>(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun unstake_item(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun unstake_land(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun unstake_land_for_merge(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut StakingPool, arg2: address, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_function_not_ready()
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

    public entry fun upgrade_category_slot<T0>(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_misc_slot_7_gold_bar(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_misc_slot_8_chaos_seed(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_misc_slot_8_crystal(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_misc_slots_stone_blocks(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_misc_slots_water(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_misc_slots_wooden_planks(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_prod_slot_4_chaos_seed(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_prod_slot_5_dawnstone(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    fun upgrade_slot<T0>(arg0: &mut StakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_version(arg0: &LandAdminCap, arg1: &mut StakingPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.version;
        assert!(v0 < 11, 13906836858697940991);
        arg1.version = 11;
        let v1 = VersionUpdated{
            admin       : 0x2::tx_context::sender(arg2),
            old_version : v0,
            new_version : 11,
        };
        0x2::event::emit<VersionUpdated>(v1);
    }

    fun user_has_staked_nfts(arg0: &UserInfo) : bool {
        !0x1::vector::is_empty<LandInfo>(&arg0.lands) || !0x1::vector::is_empty<ItemInfo>(&arg0.items)
    }

    fun validate_and_consume_coin<T0>(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun withdraw_item<T0: store + key>(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun withdraw_land(arg0: &mut StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    // decompiled from Move bytecode v7
}

