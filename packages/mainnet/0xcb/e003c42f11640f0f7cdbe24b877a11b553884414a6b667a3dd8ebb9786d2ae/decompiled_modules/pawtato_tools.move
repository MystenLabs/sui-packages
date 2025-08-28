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
            let v1 = 0x1::string::utf8(b"Name");
            0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v1);
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
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u64_to_string(v1)
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, v2);
        };
    }

    public fun add_quality_if_missing(arg0: &mut TOOL) {
        let v0 = 0x1::string::utf8(b"Quality");
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u64_to_string(100));
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
        arg1.minted = arg1.minted - 1;
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

    fun calculate_tier_based_multiplier(arg0: &0x1::string::String, arg1: u64, arg2: vector<u64>) : u64 {
        assert!(0x1::vector::length<u64>(&arg2) == 12, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Common";
        if (v0 == &v1) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 0), *0x1::vector::borrow<u64>(&arg2, 1), arg1)
        } else {
            let v3 = b"Uncommon";
            if (v0 == &v3) {
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 2), *0x1::vector::borrow<u64>(&arg2, 3), arg1)
            } else {
                let v4 = b"Rare";
                if (v0 == &v4) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 4), *0x1::vector::borrow<u64>(&arg2, 5), arg1)
                } else {
                    let v5 = b"Epic";
                    if (v0 == &v5) {
                        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 6), *0x1::vector::borrow<u64>(&arg2, 7), arg1)
                    } else {
                        let v6 = b"Legendary";
                        if (v0 == &v6) {
                            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 8), *0x1::vector::borrow<u64>(&arg2, 9), arg1)
                        } else {
                            let v7 = b"Mythic";
                            assert!(v0 == &v7, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::calculate_quality_adjusted_multiplier(*0x1::vector::borrow<u64>(&arg2, 10), *0x1::vector::borrow<u64>(&arg2, 11), arg1)
                        }
                    }
                }
            }
        }
    }

    fun create_tool_nft(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : TOOL {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Name"), arg1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Tier"), arg3);
        let v1 = get_tier_durability(&arg3);
        let v2 = if (v1 == 999999) {
            0x1::string::utf8(b"Infinite")
        } else {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u64_to_string(v1)
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Durability"), v2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Category"), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_string(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(arg0)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Quality"), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u64_to_string(arg5));
        let v3 = 0x1::string::utf8(b"https://img.pawtato.app/land/_tools/");
        0x1::string::append(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::sanitize(&arg1));
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
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_bucket_production_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_category_string(arg0: &TOOL) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"Category");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
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
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_durability_not_initialized());
        let v1 = 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0);
        let v2 = b"Infinite";
        if (0x1::string::as_bytes(v1) == &v2) {
            999999
        } else {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(v1)
        }
    }

    public fun get_hammer_chisel_resource_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 30000);
        0x1::vector::push_back<u64>(v4, 28000);
        0x1::vector::push_back<u64>(v4, 26000);
        0x1::vector::push_back<u64>(v4, 24000);
        0x1::vector::push_back<u64>(v4, 22000);
        0x1::vector::push_back<u64>(v4, 20000);
        0x1::vector::push_back<u64>(v4, 18000);
        0x1::vector::push_back<u64>(v4, 16000);
        0x1::vector::push_back<u64>(v4, 15000);
        0x1::vector::push_back<u64>(v4, 13000);
        0x1::vector::push_back<u64>(v4, 12000);
        0x1::vector::push_back<u64>(v4, 10000);
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_hammer_chisel_time_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 10000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 7000);
        0x1::vector::push_back<u64>(v4, 6500);
        0x1::vector::push_back<u64>(v4, 5500);
        0x1::vector::push_back<u64>(v4, 5000);
        0x1::vector::push_back<u64>(v4, 4000);
        0x1::vector::push_back<u64>(v4, 3000);
        0x1::vector::push_back<u64>(v4, 2000);
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_handsaw_resource_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 30000);
        0x1::vector::push_back<u64>(v4, 28000);
        0x1::vector::push_back<u64>(v4, 26000);
        0x1::vector::push_back<u64>(v4, 24000);
        0x1::vector::push_back<u64>(v4, 22000);
        0x1::vector::push_back<u64>(v4, 20000);
        0x1::vector::push_back<u64>(v4, 18000);
        0x1::vector::push_back<u64>(v4, 16000);
        0x1::vector::push_back<u64>(v4, 15000);
        0x1::vector::push_back<u64>(v4, 13000);
        0x1::vector::push_back<u64>(v4, 12000);
        0x1::vector::push_back<u64>(v4, 10000);
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_handsaw_time_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 10000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 7000);
        0x1::vector::push_back<u64>(v4, 6500);
        0x1::vector::push_back<u64>(v4, 5500);
        0x1::vector::push_back<u64>(v4, 5000);
        0x1::vector::push_back<u64>(v4, 4000);
        0x1::vector::push_back<u64>(v4, 3000);
        0x1::vector::push_back<u64>(v4, 2000);
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_idol_raffle_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_item_type(arg0: &TOOL) : u8 {
        arg0.item_type
    }

    public fun get_kiln_resource_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 30000);
        0x1::vector::push_back<u64>(v4, 28000);
        0x1::vector::push_back<u64>(v4, 26000);
        0x1::vector::push_back<u64>(v4, 24000);
        0x1::vector::push_back<u64>(v4, 22000);
        0x1::vector::push_back<u64>(v4, 20000);
        0x1::vector::push_back<u64>(v4, 18000);
        0x1::vector::push_back<u64>(v4, 16000);
        0x1::vector::push_back<u64>(v4, 15000);
        0x1::vector::push_back<u64>(v4, 13000);
        0x1::vector::push_back<u64>(v4, 12000);
        0x1::vector::push_back<u64>(v4, 10000);
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_kiln_time_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
        let v0 = get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 10000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 9000);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 8000);
        0x1::vector::push_back<u64>(v4, 7000);
        0x1::vector::push_back<u64>(v4, 6500);
        0x1::vector::push_back<u64>(v4, 5500);
        0x1::vector::push_back<u64>(v4, 5000);
        0x1::vector::push_back<u64>(v4, 4000);
        0x1::vector::push_back<u64>(v4, 3000);
        0x1::vector::push_back<u64>(v4, 2000);
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_magic_siphon_production_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
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
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
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
            0x1::option::some<u64>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x1::option::borrow<0x1::string::String>(&v0)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_shovel_urr_chance(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
    }

    public fun get_storage_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tool());
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
        calculate_tier_based_multiplier(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v2)), v3)
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
        let v4 = v2;
        let v5 = 0x2::random::generate_u64(&mut v1) % 100 + 1;
        if (v0 == @0x30fa04a11a6e96e34e5a9fb16d126ee6481b8bb65cfbf45c8959d9c56b38abd3 || v0 == @0xbff7d619bc376d09745addd8d252461cddad51e73b5259100744117f4cba4b15) {
            v4 = 0x1::string::utf8(b"Rare");
        };
        let v6 = arg0.minted + 1;
        arg0.minted = v6;
        let v7 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(arg1);
        let v8 = create_tool_nft(arg1, v7, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_description(arg1), v4, v6, v5, arg4);
        let v9 = ToolCraftedV2{
            nft_id         : 0x2::object::id<TOOL>(&v8),
            token_id       : v6,
            minter         : v0,
            name           : v7,
            tier           : v4,
            item_type      : arg1,
            payment_method : arg3,
            roll           : v3,
            quality        : v5,
        };
        0x2::event::emit<ToolCraftedV2>(v9);
        v8
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
        let v2 = if (0x1::vector::length<u8>(v1) > 0) {
            *0x1::vector::borrow<u8>(v1, 0x1::vector::length<u8>(v1) - 1)
        } else {
            0
        };
        if (v2 != 41) {
            0x1::string::append(&mut arg0.name, 0x1::string::utf8(b" (burned)"));
            let v3 = 0x1::string::utf8(b"Name");
            let v4 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v3);
            0x1::string::append(&mut v4, 0x1::string::utf8(b" (burned)"));
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v3) = v4;
            let v5 = 0x1::string::utf8(b"Burned");
            if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v5)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v5, 0x1::string::utf8(b"Yes"));
            };
        };
    }

    public fun mark_tool_as_burned_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut TOOL) {
        mark_tool_as_burned(arg1);
    }

    public entry fun mint_storage_with_sui(arg0: &mut ToolCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<TOOL>, arg3: &0x2::random::Random, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 3000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 3000000000, arg6), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::kiosk::lock<TOOL>(arg4, arg5, arg2, internal_mint_tool(arg0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg3, 0x1::string::utf8(b"sui"), arg6));
    }

    public entry fun update_supply_limit(arg0: &ToolAdminCap, arg1: &mut ToolCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.supply_limit = arg2;
        let v0 = SupplyLimitUpdated{new_limit: arg2};
        0x2::event::emit<SupplyLimitUpdated>(v0);
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
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::u64_to_string(v1)
        };
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v2)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v2) = v3;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v2, v3);
        };
        let v4 = 0x1::string::utf8(b"Name");
        let v5 = 0x1::string::utf8(b"https://img.pawtato.app/land/_tools/");
        0x1::string::append(&mut v5, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::sanitize(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v4)));
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

