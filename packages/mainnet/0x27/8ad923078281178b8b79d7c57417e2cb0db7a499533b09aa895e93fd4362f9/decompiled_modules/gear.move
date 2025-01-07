module 0x278ad923078281178b8b79d7c57417e2cb0db7a499533b09aa895e93fd4362f9::gear {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct GEAR has drop {
        dummy_field: bool,
    }

    struct Gear has store, key {
        id: 0x2::object::UID,
        exported: bool,
        name: 0x1::string::String,
        description: 0x1::string::String,
        item_id: u128,
        type: 0x1::string::String,
        level: u64,
        audio: u64,
        visual: u64,
        skill_1: 0x1::option::Option<Skill>,
        skill_2: 0x1::option::Option<Skill>,
        img_url: 0x1::string::String,
    }

    struct Skill has drop, store {
        effect: u64,
        type: 0x1::string::String,
        interval: u64,
        max_duration: u64,
        cooldown: u64,
    }

    struct UpdateCap has store, key {
        id: 0x2::object::UID,
        gear_id: 0x2::object::ID,
        owner: address,
    }

    public fun add_skill(arg0: &mut Gear, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            assert!(0x1::option::is_none<Skill>(&arg0.skill_1), 1);
            let v0 = Skill{
                effect       : arg2,
                type         : arg3,
                interval     : arg4,
                max_duration : arg5,
                cooldown     : arg6,
            };
            0x1::option::fill<Skill>(&mut arg0.skill_1, v0);
        };
        if (arg1 == 2) {
            assert!(0x1::option::is_none<Skill>(&arg0.skill_2), 1);
            let v1 = Skill{
                effect       : arg2,
                type         : arg3,
                interval     : arg4,
                max_duration : arg5,
                cooldown     : arg6,
            };
            0x1::option::fill<Skill>(&mut arg0.skill_2, v1);
        };
    }

    public fun admin_create_transfer_token(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::create_and_transfer<Gear>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gear>(arg0), arg1, arg2, arg3)
    }

    public fun admin_issue_update_cap_for_cw(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gear>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : UpdateCap {
        UpdateCap{
            id      : 0x2::object::new(arg3),
            gear_id : 0x2::object::id_from_address(arg2),
            owner   : arg1,
        }
    }

    public fun admin_mint(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gear>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u128, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Gear {
        let v0 = Gear{
            id          : 0x2::object::new(arg9),
            exported    : false,
            name        : arg1,
            description : arg2,
            item_id     : arg3,
            type        : arg4,
            level       : arg5,
            audio       : arg6,
            visual      : arg7,
            skill_1     : 0x1::option::none<Skill>(),
            skill_2     : 0x1::option::none<Skill>(),
            img_url     : arg8,
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Gear>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Gear, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Gear>(arg0), &v0);
        v0
    }

    public fun create_kiosk_for_ncw(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::object::ID) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg0, arg1)
    }

    public fun export_gear_to_kiosk(arg0: Gear, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_is_ob_kiosk(arg1);
        arg0.exported = true;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Gear>(arg1, arg0, arg2);
    }

    public fun gear_can_be_updated(arg0: &Gear) : bool {
        !arg0.exported
    }

    public fun gear_uid_mut(arg0: &mut Gear) : &mut 0x2::object::UID {
        assert!(gear_can_be_updated(arg0), 0);
        &mut arg0.id
    }

    public fun get_gear_audio(arg0: &Gear) : u64 {
        arg0.audio
    }

    public fun get_gear_description(arg0: &Gear) : 0x1::string::String {
        arg0.description
    }

    public fun get_gear_id(arg0: &Gear) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_gear_img(arg0: &Gear) : 0x1::string::String {
        arg0.img_url
    }

    public fun get_gear_level(arg0: &Gear) : u64 {
        arg0.level
    }

    public fun get_gear_name(arg0: &Gear) : 0x1::string::String {
        arg0.name
    }

    public fun get_gear_type(arg0: &Gear) : 0x1::string::String {
        arg0.type
    }

    public fun get_gear_visual(arg0: &Gear) : u64 {
        arg0.visual
    }

    public fun get_skill_cooldown(arg0: &Gear, arg1: u64) : u64 {
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow<Skill>(&arg0.skill_1).cooldown
        } else {
            0x1::option::borrow<Skill>(&arg0.skill_2).cooldown
        }
    }

    public fun get_skill_effect(arg0: &Gear, arg1: u64) : u64 {
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow<Skill>(&arg0.skill_1).effect
        } else {
            0x1::option::borrow<Skill>(&arg0.skill_2).effect
        }
    }

    public fun get_skill_interval(arg0: &Gear, arg1: u64) : u64 {
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow<Skill>(&arg0.skill_1).interval
        } else {
            0x1::option::borrow<Skill>(&arg0.skill_2).interval
        }
    }

    public fun get_skill_max_duration(arg0: &Gear, arg1: u64) : u64 {
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow<Skill>(&arg0.skill_1).max_duration
        } else {
            0x1::option::borrow<Skill>(&arg0.skill_2).max_duration
        }
    }

    public fun get_skill_type(arg0: &Gear, arg1: u64) : 0x1::string::String {
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow<Skill>(&arg0.skill_1).type
        } else {
            0x1::option::borrow<Skill>(&arg0.skill_2).type
        }
    }

    public fun import_gear_to_cw(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::TransferToken<Gear>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Gear, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<Gear>(arg1, arg2, arg4);
        let v2 = v1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::confirm<Gear, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>(v0, arg0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::inner_mut<Gear>(&mut v2));
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<Gear>(v2, arg3);
    }

    fun init(arg0: GEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<GEAR, Gear>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<GEAR>(arg0, arg1);
        let v4 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gear>(&v3);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"item_id"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"audio"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"visual"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"skill_1"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"skill_2"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"url"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{item_id}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{audio}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{visual}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{skill_1}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{skill_2}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{img_url}"));
        let v9 = 0x2::display::new_with_fields<Gear>(&v3, v5, v7, arg1);
        0x2::display::update_version<Gear>(&mut v9);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Gear>(&v3, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Gear>(&mut v13, &v12);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Gear>(&mut v13, &v12);
        let v14 = 0x1::vector::empty<address>();
        let v15 = &mut v14;
        0x1::vector::push_back<address>(v15, @0x58e8af235a3caa7cbb2ec88782e90eb7fe6026a9afff511bedaacff05eb1f835);
        0x1::vector::push_back<address>(v15, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v16 = 0x1::vector::empty<u16>();
        let v17 = &mut v16;
        0x1::vector::push_back<u16>(v17, 9500);
        0x1::vector::push_back<u16>(v17, 500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Gear>(v4, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v14, v16), arg1), 1000, arg1);
        let (v18, v19) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Gear>(&v3, arg1);
        let v20 = v19;
        let v21 = v18;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::enforce<Gear, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>(&mut v21, &v20);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Gear, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new<Gear, 0x2::sui::SUI>(v4, &v13, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::no_protection(), arg1));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gear>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Gear>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Gear>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v20, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Gear>>(v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Gear>>(v13);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Gear, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v21);
    }

    fun skill_exists(arg0: u64) : bool {
        arg0 == 1 || arg0 == 2
    }

    public fun unlock_gear_in_cw(arg0: &mut Gear, arg1: UpdateCap) {
        let UpdateCap {
            id      : v0,
            gear_id : v1,
            owner   : _,
        } = arg1;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 3);
        0x2::object::delete(v0);
        arg0.exported = false;
    }

    public fun update_gear_audio(arg0: &mut Gear, arg1: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        arg0.audio = arg1;
    }

    public fun update_gear_description(arg0: &mut Gear, arg1: 0x1::string::String) {
        assert!(gear_can_be_updated(arg0), 0);
        arg0.description = arg1;
    }

    public fun update_gear_img(arg0: &mut Gear, arg1: 0x1::string::String) {
        assert!(gear_can_be_updated(arg0), 0);
        arg0.img_url = arg1;
    }

    public fun update_gear_level(arg0: &mut Gear, arg1: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        arg0.level = arg1;
    }

    public fun update_gear_visual(arg0: &mut Gear, arg1: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        arg0.visual = arg1;
    }

    public fun update_skill(arg0: &mut Gear, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            let v0 = 0x1::option::extract<Skill>(&mut arg0.skill_1);
            let v1 = Skill{
                effect       : arg2,
                type         : v0.type,
                interval     : arg3,
                max_duration : arg4,
                cooldown     : arg5,
            };
            0x1::option::fill<Skill>(&mut arg0.skill_1, v1);
        };
        if (arg1 == 2) {
            let v2 = 0x1::option::extract<Skill>(&mut arg0.skill_2);
            let v3 = Skill{
                effect       : arg2,
                type         : v2.type,
                interval     : arg3,
                max_duration : arg4,
                cooldown     : arg5,
            };
            0x1::option::fill<Skill>(&mut arg0.skill_2, v3);
        };
    }

    public fun update_skill_cooldown(arg0: &mut Gear, arg1: u64, arg2: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_1).cooldown = arg2;
        };
        if (arg1 == 2) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_2).cooldown = arg2;
        };
    }

    public fun update_skill_effect(arg0: &mut Gear, arg1: u64, arg2: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_1).effect = arg2;
        };
        if (arg1 == 2) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_2).effect = arg2;
        };
    }

    public fun update_skill_interval(arg0: &mut Gear, arg1: u64, arg2: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_1).interval = arg2;
        };
        if (arg1 == 2) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_2).interval = arg2;
        };
    }

    public fun update_skill_max_duration(arg0: &mut Gear, arg1: u64, arg2: u64) {
        assert!(gear_can_be_updated(arg0), 0);
        assert!(skill_exists(arg1), 2);
        if (arg1 == 1) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_1).max_duration = arg2;
        };
        if (arg1 == 2) {
            0x1::option::borrow_mut<Skill>(&mut arg0.skill_2).max_duration = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

