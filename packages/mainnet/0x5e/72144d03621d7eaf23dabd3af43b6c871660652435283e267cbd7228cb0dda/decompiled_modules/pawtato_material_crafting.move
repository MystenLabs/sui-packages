module 0x5e72144d03621d7eaf23dabd3af43b6c871660652435283e267cbd7228cb0dda::pawtato_material_crafting {
    struct PAWTATO_MATERIAL_CRAFTING has drop {
        dummy_field: bool,
    }

    struct CraftingSystem has key {
        id: 0x2::object::UID,
        treasury_address: address,
        version: u64,
        paused: bool,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
        tato_instant_fee_per_hour: u64,
        recipes: 0x2::table::Table<u8, Recipe>,
        recipe_resource_types: vector<u8>,
    }

    struct CraftingQueue has key {
        id: 0x2::object::UID,
        user_crafts: 0x2::table::Table<address, vector<CraftJob>>,
        active_crafters: vector<address>,
    }

    struct CraftingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Recipe has copy, drop, store {
        name: 0x1::string::String,
        required_tool_type: u8,
        resource_type: u8,
        base_duration_ms: u64,
        input_resources: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        output_resource_cointype: 0x1::string::String,
        active: bool,
        total_crafts: u64,
        input_resource_multiplier_flags: vector<bool>,
        apply_time_multiplier: bool,
        durability_cost_per_ten_items: u16,
    }

    struct CraftJob has copy, drop, store {
        resource_type: u8,
        amount: u64,
        tool_nft_id: 0x2::object::ID,
        started_at: u64,
        duration: u64,
    }

    struct MaterialProcessingStarted has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        index: u64,
        started_at: u64,
        duration: u64,
        tool_nft_id: 0x2::object::ID,
    }

    struct MaterialProcessingClaimed has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        index: u64,
    }

    struct MaterialProcessingInstant has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        instant_fee: u64,
    }

    public entry fun add_pawtato_package_cap(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) {
        0x1::option::fill<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap, arg2);
    }

    fun add_user_to_active_crafters(arg0: &mut vector<address>, arg1: address) {
        if (!is_user_in_active_crafters(arg0, arg1)) {
            0x1::vector::push_back<address>(arg0, arg1);
        };
    }

    public entry fun automated_migrate_processing_queue(arg0: &CraftingAdminCap, arg1: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::MaterialProcessingQueue, arg2: &mut CraftingQueue, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::get_all_processors(arg1);
        let v1 = 0x1::vector::length<address>(&v0);
        if (v1 == 0) {
            return
        };
        assert!(arg3 < v1, 817);
        assert!(arg3 < arg4, 817);
        let v2 = if (arg4 > v1) {
            v1
        } else {
            arg4
        };
        while (arg3 < v2) {
            let v3 = *0x1::vector::borrow<address>(&v0, arg3);
            let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::get_user_jobs(arg1, v3);
            if (!0x1::vector::is_empty<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::ProcessingDetails>(&v4)) {
                if (!0x2::table::contains<address, vector<CraftJob>>(&arg2.user_crafts, v3)) {
                    let v5 = convert_processing_to_craft_jobs(v4);
                    if (!0x1::vector::is_empty<CraftJob>(&v5)) {
                        0x2::table::add<address, vector<CraftJob>>(&mut arg2.user_crafts, v3, v5);
                        let v6 = &mut arg2.active_crafters;
                        add_user_to_active_crafters(v6, v3);
                    };
                };
            };
            arg3 = arg3 + 1;
        };
    }

    fun calculate_craft_duration(arg0: &Recipe, arg1: u64, arg2: u64) : u64 {
        if (!arg0.apply_time_multiplier) {
            return arg0.base_duration_ms * arg1
        };
        arg0.base_duration_ms * arg1 * arg2 / 10000
    }

    fun calculate_instant_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 3600000;
        let v1 = v0;
        if (arg0 % 3600000 > 0) {
            v1 = v0 + 1;
        };
        v1 * arg1
    }

    fun calculate_resource_cost(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : u64 {
        if (!arg2) {
            return arg0 * arg1
        };
        arg0 * arg1 * arg3 / 10000
    }

    public(friend) fun check_not_paused(arg0: &CraftingSystem) {
        assert!(!arg0.paused, 801);
    }

    public(friend) fun check_version(arg0: &CraftingSystem) {
        assert!(arg0.version == 1, 800);
    }

    public entry fun claim_craft<T0>(arg0: &mut CraftingSystem, arg1: &mut CraftingQueue, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, vector<CraftJob>>(&arg1.user_crafts, v0), 809);
        let v1 = 0x2::table::borrow_mut<address, vector<CraftJob>>(&mut arg1.user_crafts, v0);
        assert!(arg5 < 0x1::vector::length<CraftJob>(v1), 809);
        let v2 = 0x1::vector::borrow<CraftJob>(v1, arg5);
        assert!(0x2::clock::timestamp_ms(arg4) >= v2.started_at + v2.duration, 808);
        let v3 = v2.resource_type;
        let v4 = v2.amount;
        0x1::vector::remove<CraftJob>(v1, arg5);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::clear_item_cooldown_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v2.tool_nft_id);
        if (0x1::vector::is_empty<CraftJob>(v1)) {
            let v5 = &mut arg1.active_crafters;
            remove_user_from_active_crafters(v5, v0);
        };
        assert!(0x2::table::contains<u8, Recipe>(&arg0.recipes, v3), 802);
        let v6 = 0x2::table::borrow<u8, Recipe>(&arg0.recipes, v3);
        assert!(v6.output_resource_cointype == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(), 816);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_coin<T0>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<T0>(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg3, 0x2::object::id<CraftingSystem>(arg0), v4 * 1000000000, arg6), v0);
        let v7 = MaterialProcessingClaimed{
            user      : v0,
            coin_type : v6.output_resource_cointype,
            amount    : v4,
            index     : arg5,
        };
        0x2::event::emit<MaterialProcessingClaimed>(v7);
    }

    public entry fun claim_instant_craft<T0>(arg0: &mut CraftingSystem, arg1: &mut CraftingQueue, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: &0x2::clock::Clock, arg5: u64, arg6: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::table::contains<address, vector<CraftJob>>(&arg1.user_crafts, v0), 809);
        let v2 = 0x2::table::borrow_mut<address, vector<CraftJob>>(&mut arg1.user_crafts, v0);
        assert!(arg5 < 0x1::vector::length<CraftJob>(v2), 809);
        let v3 = 0x1::vector::borrow<CraftJob>(v2, arg5);
        let v4 = v3.started_at + v3.duration;
        let v5 = if (v1 >= v4) {
            0
        } else {
            v4 - v1
        };
        let v6 = calculate_instant_fee(v5, arg0.tato_instant_fee_per_hour);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg6) >= v6, 811);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg6, arg0.treasury_address);
        let v7 = v3.resource_type;
        let v8 = v3.amount;
        0x1::vector::remove<CraftJob>(v2, arg5);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::clear_item_cooldown_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v3.tool_nft_id);
        if (0x1::vector::is_empty<CraftJob>(v2)) {
            let v9 = &mut arg1.active_crafters;
            remove_user_from_active_crafters(v9, v0);
        };
        assert!(0x2::table::contains<u8, Recipe>(&arg0.recipes, v7), 802);
        let v10 = 0x2::table::borrow<u8, Recipe>(&arg0.recipes, v7);
        assert!(v10.output_resource_cointype == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(), 816);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_coin<T0>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<T0>(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg3, 0x2::object::id<CraftingSystem>(arg0), v8 * 1000000000, arg7), v0);
        let v11 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : v10.output_resource_cointype,
            amount      : v8,
            instant_fee : v6,
        };
        0x2::event::emit<MaterialProcessingInstant>(v11);
    }

    fun consume_tool_durability_for_crafting(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u16, arg5: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) {
        assert!(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::consume_durability(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg5, arg0, arg1, arg2), (arg3 * (arg4 as u64) + 9) / 10), 805);
    }

    fun convert_processing_to_craft_jobs(arg0: vector<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::ProcessingDetails>) : vector<CraftJob> {
        let v0 = 0x1::vector::empty<CraftJob>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::ProcessingDetails>(&arg0)) {
            let (v2, v3, v4, v5, v6) = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::extract_processing_details(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing::ProcessingDetails>(&arg0, v1));
            let v7 = CraftJob{
                resource_type : v2,
                amount        : v3,
                tool_nft_id   : v6,
                started_at    : v4,
                duration      : v5,
            };
            0x1::vector::push_back<CraftJob>(&mut v0, v7);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun create_recipe(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<u64>, arg8: vector<bool>, arg9: 0x1::string::String, arg10: bool, arg11: u16, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(!0x2::table::contains<u8, Recipe>(&arg1.recipes, arg4), 818);
        assert!(0x1::string::length(&arg2) > 0, 812);
        assert!(0x1::string::length(&arg9) > 0, 812);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<u64>(&arg7), 813);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<bool>(&arg8), 813);
        assert!(arg11 > 0, 817);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&arg6, v1);
            let v3 = 0x1::vector::borrow<u64>(&arg7, v1);
            assert!(0x1::string::length(v2) > 0, 812);
            assert!(*v3 > 0, 804);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, *v2, *v3);
            v1 = v1 + 1;
        };
        let v4 = Recipe{
            name                            : arg2,
            required_tool_type              : arg3,
            resource_type                   : arg4,
            base_duration_ms                : arg5,
            input_resources                 : v0,
            output_resource_cointype        : arg9,
            active                          : true,
            total_crafts                    : 0,
            input_resource_multiplier_flags : arg8,
            apply_time_multiplier           : arg10,
            durability_cost_per_ten_items   : arg11,
        };
        0x2::table::add<u8, Recipe>(&mut arg1.recipes, arg4, v4);
        0x1::vector::push_back<u8>(&mut arg1.recipe_resource_types, arg4);
    }

    public entry fun eject_pawtato_package_cap(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(0x1::option::extract<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap), 0x2::tx_context::sender(arg2));
    }

    fun find_available_tool(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &CraftingQueue, arg2: address, arg3: u8, arg4: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) : (0x2::object::ID, u64, u64) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg0, arg2, arg3);
        assert!(0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0) > 0, 806);
        let v1 = if (0x2::table::contains<address, vector<CraftJob>>(&arg1.user_crafts, arg2)) {
            0x2::table::borrow<address, vector<CraftJob>>(&arg1.user_crafts, arg2)
        } else {
            let v2 = 0x1::vector::empty<CraftJob>();
            &v2
        };
        let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0, 0));
        assert!(!is_tool_in_use(v1, v3), 806);
        let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(arg4, arg0, arg2, v3);
        (v3, read_processing_time_mul(v4), read_processing_resource_mul(v4))
    }

    public fun get_all_recipes(arg0: &CraftingSystem) : vector<Recipe> {
        let v0 = 0x1::vector::empty<Recipe>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.recipe_resource_types)) {
            0x1::vector::push_back<Recipe>(&mut v0, *0x2::table::borrow<u8, Recipe>(&arg0.recipes, *0x1::vector::borrow<u8>(&arg0.recipe_resource_types, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun get_multiplier_flag_for_resource(arg0: &Recipe, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::string::String, u64>(&arg0.input_resources)) {
            let (v1, _) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&arg0.input_resources, v0);
            if (v1 == arg1) {
                return *0x1::vector::borrow<bool>(&arg0.input_resource_multiplier_flags, v0)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun get_user_craft_jobs(arg0: &CraftingQueue, arg1: address) : vector<CraftJob> {
        if (!0x2::table::contains<address, vector<CraftJob>>(&arg0.user_crafts, arg1)) {
            return 0x1::vector::empty<CraftJob>()
        };
        *0x2::table::borrow<address, vector<CraftJob>>(&arg0.user_crafts, arg1)
    }

    public fun get_user_crafts_count(arg0: &CraftingQueue, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<CraftJob>>(&arg0.user_crafts, arg1)) {
            return 0
        };
        0x1::vector::length<CraftJob>(0x2::table::borrow<address, vector<CraftJob>>(&arg0.user_crafts, arg1))
    }

    fun init(arg0: PAWTATO_MATERIAL_CRAFTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CraftingAdminCap{id: 0x2::object::new(arg1)};
        let v1 = CraftingSystem{
            id                        : 0x2::object::new(arg1),
            treasury_address          : @0xb53971d0e1e7835fd6f3ee07725d3f5b8b9f4d2100458a797d4c51b47c0ea3a1,
            version                   : 1,
            paused                    : false,
            pawtato_package_cap       : 0x1::option::none<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(),
            tato_instant_fee_per_hour : 20000000000,
            recipes                   : 0x2::table::new<u8, Recipe>(arg1),
            recipe_resource_types     : 0x1::vector::empty<u8>(),
        };
        let v2 = CraftingQueue{
            id              : 0x2::object::new(arg1),
            user_crafts     : 0x2::table::new<address, vector<CraftJob>>(arg1),
            active_crafters : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<CraftingSystem>(v1);
        0x2::transfer::share_object<CraftingQueue>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_MATERIAL_CRAFTING>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<CraftingAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun instant_craft<T0, T1, T2, T3, T4, T5>(arg0: &mut CraftingSystem, arg1: &CraftingQueue, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: u8, arg5: u64, arg6: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: 0x2::coin::Coin<T4>, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(0x2::table::contains<u8, Recipe>(&arg0.recipes, arg4), 802);
        let v1 = 0x2::table::borrow_mut<u8, Recipe>(&mut arg0.recipes, arg4);
        assert!(v1.active, 803);
        let (v2, v3, v4) = find_available_tool(arg2, arg1, v0, v1.required_tool_type, 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap));
        let v5 = calculate_instant_fee(calculate_craft_duration(v1, arg5, v3), arg0.tato_instant_fee_per_hour);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg6) >= v5, 811);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg6, arg0.treasury_address);
        let v6 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v7 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>();
        let v8 = 0x2::coin::value<T0>(&arg7);
        if (v8 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v1.input_resources, &v7)) {
                assert!(v8 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v1.input_resources, &v7), arg5, get_multiplier_flag_for_resource(v1, &v7), v4), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg3, arg7);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, v7, v8);
            } else {
                0x2::coin::destroy_zero<T0>(arg7);
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        let v9 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T1>();
        let v10 = 0x2::coin::value<T1>(&arg8);
        if (v10 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v1.input_resources, &v9)) {
                assert!(v10 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v1.input_resources, &v9), arg5, get_multiplier_flag_for_resource(v1, &v9), v4), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T1>(arg3, arg8);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, v9, v10);
            } else {
                0x2::coin::destroy_zero<T1>(arg8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(arg8);
        };
        let v11 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T2>();
        let v12 = 0x2::coin::value<T2>(&arg9);
        if (v12 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v1.input_resources, &v11)) {
                assert!(v12 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v1.input_resources, &v11), arg5, get_multiplier_flag_for_resource(v1, &v11), v4), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T2>(arg3, arg9);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, v11, v12);
            } else {
                0x2::coin::destroy_zero<T2>(arg9);
            };
        } else {
            0x2::coin::destroy_zero<T2>(arg9);
        };
        let v13 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T3>();
        let v14 = 0x2::coin::value<T3>(&arg10);
        if (v14 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v1.input_resources, &v13)) {
                assert!(v14 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v1.input_resources, &v13), arg5, get_multiplier_flag_for_resource(v1, &v13), v4), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T3>(arg3, arg10);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, v13, v14);
            } else {
                0x2::coin::destroy_zero<T3>(arg10);
            };
        } else {
            0x2::coin::destroy_zero<T3>(arg10);
        };
        let v15 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T4>();
        let v16 = 0x2::coin::value<T4>(&arg11);
        if (v16 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v1.input_resources, &v15)) {
                assert!(v16 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v1.input_resources, &v15), arg5, get_multiplier_flag_for_resource(v1, &v15), v4), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T4>(arg3, arg11);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, v15, v16);
            } else {
                0x2::coin::destroy_zero<T4>(arg11);
            };
        } else {
            0x2::coin::destroy_zero<T4>(arg11);
        };
        let v17 = 0;
        while (v17 < 0x2::vec_map::length<0x1::string::String, u64>(&v1.input_resources)) {
            let (v18, _) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&v1.input_resources, v17);
            assert!(0x2::vec_map::contains<0x1::string::String, u64>(&v6, v18), 804);
            v17 = v17 + 1;
        };
        consume_tool_durability_for_crafting(arg2, v0, v2, arg5, v1.durability_cost_per_ten_items, 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap));
        assert!(v1.output_resource_cointype == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T5>(), 816);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_coin<T5>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<T5>(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg3, 0x2::object::id<CraftingSystem>(arg0), arg5 * 1000000000, arg12), v0);
        v1.total_crafts = v1.total_crafts + 1;
        let v20 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : v1.output_resource_cointype,
            amount      : arg5,
            instant_fee : v5,
        };
        0x2::event::emit<MaterialProcessingInstant>(v20);
    }

    fun is_resource_type_in_queue(arg0: &vector<CraftJob>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CraftJob>(arg0)) {
            if (0x1::vector::borrow<CraftJob>(arg0, v0).resource_type == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_tool_in_use(arg0: &vector<CraftJob>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CraftJob>(arg0)) {
            if (0x1::vector::borrow<CraftJob>(arg0, v0).tool_nft_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_user_in_active_crafters(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun new_admin_cap(arg0: &0x2::package::UpgradeCap, arg1: &CraftingAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CraftingAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<CraftingAdminCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun read_processing_resource_mul(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL) : u64 {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_processing_resource_mul(arg0)
    }

    fun read_processing_time_mul(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL) : u64 {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_processing_time_mul(arg0)
    }

    fun remove_user_from_active_crafters(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_paused(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_recipe_active(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: u8, arg3: bool) {
        check_version(arg1);
        assert!(0x2::table::contains<u8, Recipe>(&arg1.recipes, arg2), 802);
        0x2::table::borrow_mut<u8, Recipe>(&mut arg1.recipes, arg2).active = arg3;
    }

    public entry fun set_tato_instant_fee_per_hour(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: u64) {
        arg1.tato_instant_fee_per_hour = arg2;
    }

    public entry fun start_craft<T0, T1, T2, T3, T4>(arg0: &mut CraftingSystem, arg1: &mut CraftingQueue, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: &0x2::clock::Clock, arg5: u8, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: 0x2::coin::Coin<T4>, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::table::contains<u8, Recipe>(&arg0.recipes, arg5), 802);
        let v2 = 0x2::table::borrow_mut<u8, Recipe>(&mut arg0.recipes, arg5);
        assert!(v2.active, 803);
        let (v3, v4, v5) = find_available_tool(arg2, arg1, v0, v2.required_tool_type, 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap));
        let v6 = calculate_craft_duration(v2, arg6, v4);
        let v7 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v8 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>();
        let v9 = 0x2::coin::value<T0>(&arg7);
        if (v9 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v2.input_resources, &v8)) {
                assert!(v9 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v2.input_resources, &v8), arg6, get_multiplier_flag_for_resource(v2, &v8), v5), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg3, arg7);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v7, v8, v9);
            } else {
                0x2::coin::destroy_zero<T0>(arg7);
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        let v10 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T1>();
        let v11 = 0x2::coin::value<T1>(&arg8);
        if (v11 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v2.input_resources, &v10)) {
                assert!(v11 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v2.input_resources, &v10), arg6, get_multiplier_flag_for_resource(v2, &v10), v5), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T1>(arg3, arg8);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v7, v10, v11);
            } else {
                0x2::coin::destroy_zero<T1>(arg8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(arg8);
        };
        let v12 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T2>();
        let v13 = 0x2::coin::value<T2>(&arg9);
        if (v13 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v2.input_resources, &v12)) {
                assert!(v13 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v2.input_resources, &v12), arg6, get_multiplier_flag_for_resource(v2, &v12), v5), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T2>(arg3, arg9);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v7, v12, v13);
            } else {
                0x2::coin::destroy_zero<T2>(arg9);
            };
        } else {
            0x2::coin::destroy_zero<T2>(arg9);
        };
        let v14 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T3>();
        let v15 = 0x2::coin::value<T3>(&arg10);
        if (v15 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v2.input_resources, &v14)) {
                assert!(v15 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v2.input_resources, &v14), arg6, get_multiplier_flag_for_resource(v2, &v14), v5), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T3>(arg3, arg10);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v7, v14, v15);
            } else {
                0x2::coin::destroy_zero<T3>(arg10);
            };
        } else {
            0x2::coin::destroy_zero<T3>(arg10);
        };
        let v16 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T4>();
        let v17 = 0x2::coin::value<T4>(&arg11);
        if (v17 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v2.input_resources, &v16)) {
                assert!(v17 >= calculate_resource_cost(*0x2::vec_map::get<0x1::string::String, u64>(&v2.input_resources, &v16), arg6, get_multiplier_flag_for_resource(v2, &v16), v5), 804);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T4>(arg3, arg11);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v7, v16, v17);
            } else {
                0x2::coin::destroy_zero<T4>(arg11);
            };
        } else {
            0x2::coin::destroy_zero<T4>(arg11);
        };
        let v18 = 0;
        while (v18 < 0x2::vec_map::length<0x1::string::String, u64>(&v2.input_resources)) {
            let (v19, _) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&v2.input_resources, v18);
            assert!(0x2::vec_map::contains<0x1::string::String, u64>(&v7, v19), 804);
            v18 = v18 + 1;
        };
        if (!0x2::table::contains<address, vector<CraftJob>>(&arg1.user_crafts, v0)) {
            0x2::table::add<address, vector<CraftJob>>(&mut arg1.user_crafts, v0, 0x1::vector::empty<CraftJob>());
        };
        let v21 = 0x2::table::borrow_mut<address, vector<CraftJob>>(&mut arg1.user_crafts, v0);
        assert!(!is_resource_type_in_queue(v21, arg5), 814);
        let v22 = &mut arg1.active_crafters;
        add_user_to_active_crafters(v22, v0);
        let v23 = CraftJob{
            resource_type : arg5,
            amount        : arg6,
            tool_nft_id   : v3,
            started_at    : v1,
            duration      : v6,
        };
        0x1::vector::push_back<CraftJob>(v21, v23);
        consume_tool_durability_for_crafting(arg2, v0, v3, arg6, v2.durability_cost_per_ten_items, 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap));
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_item_cooldown_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v3, v1 + 31557600000);
        v2.total_crafts = v2.total_crafts + 1;
        let v24 = MaterialProcessingStarted{
            user        : v0,
            coin_type   : v2.output_resource_cointype,
            amount      : arg6,
            index       : 0x1::vector::length<CraftJob>(v21),
            started_at  : v1,
            duration    : v6,
            tool_nft_id : v3,
        };
        0x2::event::emit<MaterialProcessingStarted>(v24);
    }

    public entry fun update_recipe(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: u8, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<u64>, arg7: vector<bool>, arg8: 0x1::string::String, arg9: bool, arg10: u16) {
        check_version(arg1);
        assert!(0x2::table::contains<u8, Recipe>(&arg1.recipes, arg2), 802);
        let v0 = 0x2::table::borrow_mut<u8, Recipe>(&mut arg1.recipes, arg2);
        assert!(0x1::string::length(&arg3) > 0, 812);
        assert!(0x1::string::length(&arg8) > 0, 812);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == 0x1::vector::length<u64>(&arg6), 813);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == 0x1::vector::length<bool>(&arg7), 813);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg5)) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(&arg5, v2);
            let v4 = 0x1::vector::borrow<u64>(&arg6, v2);
            assert!(0x1::string::length(v3) > 0, 812);
            assert!(*v4 > 0, 804);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, *v3, *v4);
            v2 = v2 + 1;
        };
        v0.name = arg3;
        v0.base_duration_ms = arg4;
        v0.input_resources = v1;
        v0.output_resource_cointype = arg8;
        v0.input_resource_multiplier_flags = arg7;
        v0.apply_time_multiplier = arg9;
        v0.durability_cost_per_ten_items = arg10;
    }

    public entry fun update_treasury_address(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &CraftingAdminCap, arg1: &mut CraftingSystem) {
        assert!(arg1.version < 1, 13906836038359187455);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

