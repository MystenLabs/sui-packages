module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools {
    struct ToolCrafted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        minter: address,
        name: 0x1::string::String,
        tier: 0x1::string::String,
        item_type: u8,
        payment_method: 0x1::string::String,
        roll: u64,
    }

    struct ToolCraftedV2 has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        minter: address,
        name: 0x1::string::String,
        tier: 0x1::string::String,
        item_type: u8,
        payment_method: 0x1::string::String,
        roll: u64,
        quality: u64,
    }

    struct SupplyLimitUpdated has copy, drop {
        new_limit: u64,
    }

    struct ToolBurned has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        name: 0x1::string::String,
        tier: 0x1::string::String,
        item_type: u8,
        burner: address,
    }

    struct PAWTATO_TOOLS has drop {
        dummy_field: bool,
    }

    struct ToolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ToolCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        supply_limit: u64,
        admin_address: address,
        treasury_address: address,
    }

    struct TOOL has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
        tier: 0x1::string::String,
        item_type: u8,
    }

    public fun add_category_if_missing(arg0: &mut TOOL) {
        let v0 = 0x1::string::utf8(b"Category");
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_string(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(arg0.item_type)));
        };
    }

    public fun add_durability_if_missing(arg0: &mut TOOL) {
        let v0 = 0x1::string::utf8(b"Durability");
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            let v1 = get_tier_durability(&arg0.tier);
            let v2 = if (v1 == 999999) {
                0x1::string::utf8(b"Infinite")
            } else {
                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(v1)
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, v2);
        };
    }

    public entry fun add_durability_to_tool(arg0: &ToolAdminCap, arg1: &mut TOOL, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun add_quality_if_missing(arg0: &mut TOOL) {
        let v0 = 0x1::string::utf8(b"Quality");
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(100));
        };
    }

    public(friend) fun burn_tool(arg0: TOOL, arg1: &mut ToolCollection, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"Name");
        let TOOL {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
            token_id    : _,
            tier        : _,
            item_type   : _,
        } = arg0;
        0x2::object::delete(v1);
        let v9 = ToolBurned{
            nft_id    : 0x2::object::id<TOOL>(&arg0),
            token_id  : arg0.token_id,
            name      : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0),
            tier      : arg0.tier,
            item_type : arg0.item_type,
            burner    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ToolBurned>(v9);
    }

    public fun burn_tool_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: TOOL, arg2: &mut ToolCollection, arg3: &mut 0x2::tx_context::TxContext) {
        burn_tool(arg1, arg2, arg3);
    }

    public fun calculate_tier_based_mul(arg0: &0x1::string::String, arg1: u64, arg2: vector<u64>) : u64 {
        assert!(0x1::vector::length<u64>(&arg2) == 12, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Common";
        if (v0 == &v1) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 0), *0x1::vector::borrow<u64>(&arg2, 1), arg1)
        } else {
            let v3 = b"Uncommon";
            if (v0 == &v3) {
                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 2), *0x1::vector::borrow<u64>(&arg2, 3), arg1)
            } else {
                let v4 = b"Rare";
                if (v0 == &v4) {
                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 4), *0x1::vector::borrow<u64>(&arg2, 5), arg1)
                } else {
                    let v5 = b"Epic";
                    if (v0 == &v5) {
                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 6), *0x1::vector::borrow<u64>(&arg2, 7), arg1)
                    } else {
                        let v6 = b"Legendary";
                        if (v0 == &v6) {
                            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 8), *0x1::vector::borrow<u64>(&arg2, 9), arg1)
                        } else {
                            let v7 = b"Mythic";
                            assert!(v0 == &v7, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 10), *0x1::vector::borrow<u64>(&arg2, 11), arg1)
                        }
                    }
                }
            }
        }
    }

    public fun consume_durability(arg0: &mut TOOL, arg1: u64) : bool {
        if (is_unbreakable(arg0)) {
            return true
        };
        let v0 = get_durability_value(arg0);
        if (v0 == 0) {
            return false
        };
        if (v0 < arg1) {
            set_durability_value(arg0, 0);
            return false
        };
        let v1 = v0 - arg1;
        set_durability_value(arg0, v1);
        v1 >= 0
    }

    fun create_tool_nft(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : TOOL {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Name"), arg1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Tier"), arg3);
        let v1 = get_tier_durability(&arg3);
        let v2 = if (v1 == 999999) {
            0x1::string::utf8(b"Infinite")
        } else {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(v1)
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Durability"), v2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Category"), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_string(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(arg0)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Quality"), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg5));
        let v3 = 0x1::string::utf8(b"https://img.pawtato.app/land/_tools/");
        0x1::string::append(&mut v3, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::sanitize(&arg1));
        0x1::string::append(&mut v3, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v3, arg3);
        0x1::string::append(&mut v3, 0x1::string::utf8(b".jpg"));
        TOOL{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            description : arg2,
            image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v3)),
            attributes  : v0,
            token_id    : arg4,
            tier        : arg3,
            item_type   : arg0,
        }
    }

    fun determine_tier(arg0: u64) : (0x1::string::String, u64) {
        let v0 = arg0 % 100000;
        if (v0 < 2) {
            return (0x1::string::utf8(b"Mythic"), v0)
        };
        if (v0 < 2 + 20) {
            return (0x1::string::utf8(b"Legendary"), v0)
        };
        if (v0 < 2 + 20 + 200) {
            return (0x1::string::utf8(b"Epic"), v0)
        };
        if (v0 < 2 + 20 + 200 + 2000) {
            return (0x1::string::utf8(b"Rare"), v0)
        };
        if (v0 < 2 + 20 + 200 + 2000 + 20000) {
            return (0x1::string::utf8(b"Uncommon"), v0)
        };
        (0x1::string::utf8(b"Common"), v0)
    }

    public fun get_attributes(arg0: &TOOL) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_axe_production_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_bucket_production_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_category_string(arg0: &TOOL) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"Category");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public(friend) fun get_durability_cost_auto_claim() : u64 {
        1
    }

    public(friend) fun get_durability_cost_urr_raffle() : u64 {
        5
    }

    public(friend) fun get_durability_crafting_cost_per_10() : u64 {
        1
    }

    public fun get_durability_mythic() : u64 {
        999999
    }

    public fun get_durability_string(arg0: &TOOL) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"Durability");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_durability_value(arg0: &TOOL) : u64 {
        let v0 = 0x1::string::utf8(b"Durability");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            let v2 = 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0);
            let v3 = b"Infinite";
            if (0x1::string::as_bytes(v2) == &v3) {
                999999
            } else {
                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(v2)
            }
        } else {
            get_tier_durability(&arg0.tier)
        }
    }

    public fun get_hammer_chisel_resource_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_hammer_chisel_time_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_handsaw_resource_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_handsaw_time_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_idol_raffle_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        if (!has_enough_durability(arg0, 5)) {
            return 10000
        };
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 15000);
        0x1::vector::push_back<u64>(v4, 20000);
        0x1::vector::push_back<u64>(v4, 25000);
        0x1::vector::push_back<u64>(v4, 30000);
        0x1::vector::push_back<u64>(v4, 35000);
        0x1::vector::push_back<u64>(v4, 40000);
        0x1::vector::push_back<u64>(v4, 50000);
        0x1::vector::push_back<u64>(v4, 60000);
        0x1::vector::push_back<u64>(v4, 70000);
        0x1::vector::push_back<u64>(v4, 85000);
        0x1::vector::push_back<u64>(v4, 95000);
        0x1::vector::push_back<u64>(v4, 110000);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_item_type(arg0: &TOOL) : u8 {
        arg0.item_type
    }

    public fun get_kiln_resource_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_kiln_time_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_magic_siphon_production_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_next_tier(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Common";
        if (v0 == &v1) {
            0x1::string::utf8(b"Uncommon")
        } else {
            let v3 = b"Uncommon";
            if (v0 == &v3) {
                0x1::string::utf8(b"Rare")
            } else {
                let v4 = b"Rare";
                if (v0 == &v4) {
                    0x1::string::utf8(b"Epic")
                } else {
                    let v5 = b"Epic";
                    if (v0 == &v5) {
                        0x1::string::utf8(b"Legendary")
                    } else {
                        let v6 = b"Legendary";
                        assert!(v0 == &v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                        0x1::string::utf8(b"Mythic")
                    }
                }
            }
        }
    }

    public fun get_pickaxe_production_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public(friend) fun get_processing_resource_mul(arg0: &TOOL) : u64 {
        let v0 = if (arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw()) {
            true
        } else if (arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel()) {
            true
        } else {
            arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln()
        };
        assert!(v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v1 = get_attributes(arg0);
        let v2 = 0x1::string::utf8(b"Tier");
        let v3 = 0x1::string::utf8(b"Quality");
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, 30000);
        0x1::vector::push_back<u64>(v5, 28000);
        0x1::vector::push_back<u64>(v5, 26000);
        0x1::vector::push_back<u64>(v5, 24000);
        0x1::vector::push_back<u64>(v5, 22000);
        0x1::vector::push_back<u64>(v5, 20000);
        0x1::vector::push_back<u64>(v5, 18000);
        0x1::vector::push_back<u64>(v5, 16000);
        0x1::vector::push_back<u64>(v5, 15000);
        0x1::vector::push_back<u64>(v5, 13000);
        0x1::vector::push_back<u64>(v5, 12000);
        0x1::vector::push_back<u64>(v5, 10000);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v1, &v2), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v1, &v3)), v4)
    }

    public(friend) fun get_processing_time_mul(arg0: &TOOL) : u64 {
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 10000);
        0x1::vector::push_back<u64>(v4, 9500);
        0x1::vector::push_back<u64>(v4, 9500);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 8500);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 7000);
        0x1::vector::push_back<u64>(v4, 7000);
        0x1::vector::push_back<u64>(v4, 6000);
        0x1::vector::push_back<u64>(v4, 6000);
        0x1::vector::push_back<u64>(v4, 5000);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public(friend) fun get_prod_mul(arg0: &TOOL) : u64 {
        if (!has_enough_durability(arg0, 1)) {
            return 10000
        };
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 10500);
        0x1::vector::push_back<u64>(v4, 11000);
        0x1::vector::push_back<u64>(v4, 11500);
        0x1::vector::push_back<u64>(v4, 12000);
        0x1::vector::push_back<u64>(v4, 12500);
        0x1::vector::push_back<u64>(v4, 13000);
        0x1::vector::push_back<u64>(v4, 14000);
        0x1::vector::push_back<u64>(v4, 15000);
        0x1::vector::push_back<u64>(v4, 16000);
        0x1::vector::push_back<u64>(v4, 17500);
        0x1::vector::push_back<u64>(v4, 18500);
        0x1::vector::push_back<u64>(v4, 20000);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_quality_string(arg0: &TOOL) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"Quality");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_quality_value(arg0: &TOOL) : 0x1::option::Option<u64> {
        let v0 = get_quality_string(arg0);
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            0x1::option::some<u64>(0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x1::option::borrow<0x1::string::String>(&v0)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_runepen_resource_multiplier(arg0: &TOOL) : u64 {
        let v0 = if (arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wooden_runepen()) {
            true
        } else if (arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_stone_runepen()) {
            true
        } else {
            arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_iron_runepen()
        };
        assert!(v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v1 = get_attributes(arg0);
        let v2 = 0x1::string::utf8(b"Tier");
        let v3 = 0x1::string::utf8(b"Quality");
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, 10000);
        0x1::vector::push_back<u64>(v5, 9500);
        0x1::vector::push_back<u64>(v5, 9500);
        0x1::vector::push_back<u64>(v5, 9000);
        0x1::vector::push_back<u64>(v5, 9000);
        0x1::vector::push_back<u64>(v5, 8500);
        0x1::vector::push_back<u64>(v5, 8000);
        0x1::vector::push_back<u64>(v5, 7000);
        0x1::vector::push_back<u64>(v5, 7000);
        0x1::vector::push_back<u64>(v5, 6000);
        0x1::vector::push_back<u64>(v5, 6000);
        0x1::vector::push_back<u64>(v5, 5000);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v1, &v2), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v1, &v3)), v4)
    }

    public fun get_runepen_time_multiplier(arg0: &TOOL) : u64 {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_shovel_urr_chance(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        if (!has_enough_durability(arg0, 5)) {
            return 0
        };
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 150);
        0x1::vector::push_back<u64>(v4, 175);
        0x1::vector::push_back<u64>(v4, 200);
        0x1::vector::push_back<u64>(v4, 225);
        0x1::vector::push_back<u64>(v4, 250);
        0x1::vector::push_back<u64>(v4, 275);
        0x1::vector::push_back<u64>(v4, 300);
        0x1::vector::push_back<u64>(v4, 350);
        0x1::vector::push_back<u64>(v4, 375);
        0x1::vector::push_back<u64>(v4, 425);
        0x1::vector::push_back<u64>(v4, 450);
        0x1::vector::push_back<u64>(v4, 500);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_storage_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        if (!has_enough_durability(arg0, 1)) {
            return 10000
        };
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 15000);
        0x1::vector::push_back<u64>(v4, 20000);
        0x1::vector::push_back<u64>(v4, 25000);
        0x1::vector::push_back<u64>(v4, 30000);
        0x1::vector::push_back<u64>(v4, 35000);
        0x1::vector::push_back<u64>(v4, 40000);
        0x1::vector::push_back<u64>(v4, 50000);
        0x1::vector::push_back<u64>(v4, 60000);
        0x1::vector::push_back<u64>(v4, 70000);
        0x1::vector::push_back<u64>(v4, 85000);
        0x1::vector::push_back<u64>(v4, 95000);
        0x1::vector::push_back<u64>(v4, 110000);
        calculate_tier_based_mul(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_tier(arg0: &TOOL) : &0x1::string::String {
        &arg0.tier
    }

    public fun get_tier_common() : vector<u8> {
        b"Common"
    }

    public fun get_tier_durability(arg0: &0x1::string::String) : u64 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Common";
        if (v0 == &v1) {
            50
        } else {
            let v3 = b"Uncommon";
            if (v0 == &v3) {
                100
            } else {
                let v4 = b"Rare";
                if (v0 == &v4) {
                    250
                } else {
                    let v5 = b"Epic";
                    if (v0 == &v5) {
                        500
                    } else {
                        let v6 = b"Legendary";
                        if (v0 == &v6) {
                            1000
                        } else {
                            let v7 = b"Mythic";
                            assert!(v0 == &v7, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                            999999
                        }
                    }
                }
            }
        }
    }

    public fun get_tier_epic() : vector<u8> {
        b"Epic"
    }

    public fun get_tier_legendary() : vector<u8> {
        b"Legendary"
    }

    public fun get_tier_mythic() : vector<u8> {
        b"Mythic"
    }

    public fun get_tier_rare() : vector<u8> {
        b"Rare"
    }

    public fun get_tier_uncommon() : vector<u8> {
        b"Uncommon"
    }

    public fun get_token_id(arg0: &TOOL) : u64 {
        arg0.token_id
    }

    public(friend) fun has_enough_durability(arg0: &TOOL, arg1: u64) : bool {
        let v0 = get_durability_value(arg0);
        is_unbreakable(arg0) || v0 == 0 && false || v0 < arg1 && false || true
    }

    fun init(arg0: PAWTATO_TOOLS, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun internal_mint_tool(arg0: &mut ToolCollection, arg1: u8, arg2: &0x2::random::Random, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : TOOL {
        if (arg0.supply_limit > 0) {
            assert!(arg0.minted < arg0.supply_limit, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_supply_limit_reached());
        };
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let (v2, v3) = determine_tier(0x2::random::generate_u64(&mut v1));
        let v4 = 0x2::random::generate_u64(&mut v1) % 100 + 1;
        let v5 = arg0.minted + 1;
        arg0.minted = v5;
        let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(arg1);
        let v7 = create_tool_nft(arg1, v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_description(arg1), v2, v5, v4, arg4);
        let v8 = ToolCraftedV2{
            nft_id         : 0x2::object::id<TOOL>(&v7),
            token_id       : v5,
            minter         : v0,
            name           : v6,
            tier           : v2,
            item_type      : arg1,
            payment_method : arg3,
            roll           : v3,
            quality        : v4,
        };
        0x2::event::emit<ToolCraftedV2>(v8);
        v7
    }

    public fun is_supply_limit_reached(arg0: &ToolCollection) : bool {
        arg0.supply_limit > 0 && arg0.minted >= arg0.supply_limit
    }

    public fun is_unbreakable(arg0: &TOOL) : bool {
        get_durability_value(arg0) == 999999
    }

    public fun mark_tool_as_burned(arg0: &mut TOOL) {
        let v0 = 0x1::string::utf8(b"https://img.pawtato.app/land/_tools/Burned-Tool.jpg");
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v0));
        let v1 = 0x1::string::as_bytes(&arg0.name);
        if (0x1::vector::length<u8>(v1) > 0) {
        };
    }

    public fun mark_tool_as_burned_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut TOOL) {
        mark_tool_as_burned(arg1);
    }

    public entry fun mint_storage_with_sui(arg0: &mut ToolCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<TOOL>, arg3: &0x2::random::Random, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun mint_tool_secured(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut ToolCollection, arg2: u8, arg3: &0x2::random::Random, arg4: &0x2::transfer_policy::TransferPolicy<TOOL>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = internal_mint_tool(arg1, arg2, arg3, arg7, arg8);
        0x2::kiosk::lock<TOOL>(arg5, arg6, arg4, v0);
        0x2::object::id<TOOL>(&v0)
    }

    public(friend) fun repair_tool_full(arg0: &mut TOOL) {
        let v0 = get_tier_durability(&arg0.tier);
        set_durability_value(arg0, v0);
    }

    public fun repair_tool_full_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut TOOL) {
        repair_tool_full(arg1);
    }

    public(friend) fun set_durability_value(arg0: &mut TOOL, arg1: u64) {
        let v0 = 0x1::string::utf8(b"Durability");
        let v1 = if (arg1 == 999999) {
            0x1::string::utf8(b"Infinite")
        } else {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1)
        };
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, v1);
        };
    }

    public entry fun update_supply_limit(arg0: &ToolAdminCap, arg1: &mut ToolCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.supply_limit = arg2;
        let v0 = SupplyLimitUpdated{new_limit: arg2};
        0x2::event::emit<SupplyLimitUpdated>(v0);
    }

    public(friend) fun update_tool_quality(arg0: &mut TOOL, arg1: u64) {
        let v0 = 0x1::string::utf8(b"Quality");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1));
        };
    }

    public fun update_tool_quality_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut TOOL, arg2: u64) {
        update_tool_quality(arg1, arg2);
    }

    public(friend) fun upgrade_tool_to_next_tier(arg0: &mut TOOL, arg1: 0x1::string::String) {
        arg0.tier = arg1;
        let v0 = 0x1::string::utf8(b"Tier");
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = arg1;
        let v1 = get_tier_durability(&arg1);
        let v2 = 0x1::string::utf8(b"Durability");
        let v3 = if (v1 == 999999) {
            0x1::string::utf8(b"Infinite")
        } else {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(v1)
        };
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v2)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v2) = v3;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v2, v3);
        };
        let v4 = 0x1::string::utf8(b"Name");
        let v5 = 0x1::string::utf8(b"https://img.pawtato.app/land/_tools/");
        0x1::string::append(&mut v5, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::sanitize(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v4)));
        0x1::string::append(&mut v5, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v5, arg1);
        0x1::string::append(&mut v5, 0x1::string::utf8(b".jpg"));
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v5));
    }

    public fun upgrade_tool_to_next_tier_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut TOOL, arg2: 0x1::string::String) {
        upgrade_tool_to_next_tier(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

