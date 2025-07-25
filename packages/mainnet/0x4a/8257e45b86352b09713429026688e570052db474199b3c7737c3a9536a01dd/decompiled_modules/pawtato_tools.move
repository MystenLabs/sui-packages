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

    struct SupplyLimitUpdated has copy, drop {
        new_limit: u64,
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

    fun create_tool_nft(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : TOOL {
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
        let v3 = 0x1::string::utf8(b"https://img.pawtato.app/land/_tools/");
        0x1::string::append(&mut v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::sanitize(&arg1));
        0x1::string::append(&mut v3, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v3, arg3);
        0x1::string::append(&mut v3, 0x1::string::utf8(b".jpg"));
        TOOL{
            id          : 0x2::object::new(arg5),
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

    public fun get_item_type(arg0: &TOOL) : u8 {
        arg0.item_type
    }

    public fun get_storage_multiplier(arg0: &TOOL) : u64 {
        assert!(arg0.item_type == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_storage(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v0 = 0x1::string::utf8(b"Tier");
        let v1 = 0x1::string::as_bytes(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(get_attributes(arg0), &v0));
        let v2 = b"Common";
        if (v1 == &v2) {
            20000
        } else {
            let v4 = b"Uncommon";
            if (v1 == &v4) {
                30000
            } else {
                let v5 = b"Rare";
                if (v1 == &v5) {
                    40000
                } else {
                    let v6 = b"Epic";
                    if (v1 == &v6) {
                        60000
                    } else {
                        let v7 = b"Legendary";
                        if (v1 == &v7) {
                            85000
                        } else {
                            let v8 = b"Mythic";
                            assert!(v1 == &v8, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                            110000
                        }
                    }
                }
            }
        }
    }

    public fun get_tier(arg0: &TOOL) : &0x1::string::String {
        &arg0.tier
    }

    fun get_tier_durability(arg0: &0x1::string::String) : u64 {
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

    public fun get_token_id(arg0: &TOOL) : u64 {
        arg0.token_id
    }

    fun init(arg0: PAWTATO_TOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PAWTATO_TOOLS>(arg0, arg1);
        let v1 = ToolCollection{
            id               : 0x2::object::new(arg1),
            minted           : 0,
            supply_limit     : 0,
            admin_address    : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            treasury_address : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
        };
        let v2 = ToolAdminCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::display::new<TOOL>(&v0, arg1);
        0x2::display::add<TOOL>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TOOL>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<TOOL>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<TOOL>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<TOOL>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<TOOL>(&v0, arg1);
        0x2::transfer::transfer<ToolAdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TOOL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TOOL>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TOOL>>(v4);
        0x2::transfer::share_object<ToolCollection>(v1);
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ToolCollection{
            id               : 0x2::object::new(arg2),
            minted           : 0,
            supply_limit     : 0,
            admin_address    : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            treasury_address : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
        };
        let v1 = ToolAdminCap{id: 0x2::object::new(arg2)};
        let v2 = 0x2::display::new<TOOL>(arg1, arg2);
        0x2::display::add<TOOL>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TOOL>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<TOOL>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<TOOL>(&mut v2, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<TOOL>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<TOOL>(arg1, arg2);
        0x2::transfer::transfer<ToolAdminCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::display::Display<TOOL>>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TOOL>>(v4, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TOOL>>(v3);
        0x2::transfer::share_object<ToolCollection>(v0);
    }

    fun internal_mint_storage(arg0: &mut ToolCollection, arg1: &0x2::random::Random, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : TOOL {
        if (arg0.supply_limit > 0) {
            assert!(arg0.minted < arg0.supply_limit, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_supply_limit_reached());
        };
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let (v1, v2) = determine_tier(0x2::random::generate_u64(&mut v0));
        let v3 = arg0.minted + 1;
        arg0.minted = v3;
        let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_storage();
        let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_name(v4);
        let v6 = create_tool_nft(v4, v5, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_type_description(v4), v1, v3, arg3);
        let v7 = ToolCrafted{
            nft_id         : 0x2::object::id<TOOL>(&v6),
            token_id       : v3,
            minter         : 0x2::tx_context::sender(arg3),
            name           : v5,
            tier           : v1,
            item_type      : v4,
            payment_method : arg2,
            roll           : v2,
        };
        0x2::event::emit<ToolCrafted>(v7);
        v6
    }

    public fun is_supply_limit_reached(arg0: &ToolCollection) : bool {
        arg0.supply_limit > 0 && arg0.minted >= arg0.supply_limit
    }

    public fun is_unbreakable(arg0: &TOOL) : bool {
        get_durability_value(arg0) == 999999
    }

    public entry fun mint_storage_with_sui(arg0: &mut ToolCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<TOOL>, arg3: &0x2::random::Random, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 3000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 3000000000, arg6), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::kiosk::lock<TOOL>(arg4, arg5, arg2, internal_mint_storage(arg0, arg3, 0x1::string::utf8(b"sui"), arg6));
    }

    public entry fun update_supply_limit(arg0: &ToolAdminCap, arg1: &mut ToolCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.supply_limit = arg2;
        let v0 = SupplyLimitUpdated{new_limit: arg2};
        0x2::event::emit<SupplyLimitUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

