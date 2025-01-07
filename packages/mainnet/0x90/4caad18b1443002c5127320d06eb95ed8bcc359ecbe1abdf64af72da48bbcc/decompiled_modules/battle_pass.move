module 0x904caad18b1443002c5127320d06eb95ed8bcc359ecbe1abdf64af72da48bbcc::battle_pass {
    struct BATTLE_PASS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct BattlePass has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        level: u64,
        level_cap: u64,
        xp: u64,
        xp_to_next_level: u64,
        rarity: u64,
        season: u64,
        in_game: bool,
    }

    struct UnlockUpdatesTicket has store, key {
        id: 0x2::object::UID,
        battle_pass_id: 0x2::object::ID,
    }

    public fun create_unlock_updates_ticket(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BattlePass>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : UnlockUpdatesTicket {
        UnlockUpdatesTicket{
            id             : 0x2::object::new(arg2),
            battle_pass_id : arg1,
        }
    }

    public fun export_to_kiosk(arg0: BattlePass, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_is_ob_kiosk(arg1);
        arg0.in_game = false;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<BattlePass>(arg1, arg0, arg2);
    }

    public fun import_battlepass_to_cw(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::TransferToken<BattlePass>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<BattlePass, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<BattlePass>(arg1, arg2, arg4);
        let v2 = v1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::confirm<BattlePass, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>(v0, arg0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::inner_mut<BattlePass>(&mut v2));
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<BattlePass>(v2, arg3);
    }

    fun init(arg0: BATTLE_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<BATTLE_PASS, BattlePass>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<BATTLE_PASS>(arg0, arg1);
        let v4 = 0x2::display::new<BattlePass>(&v3, arg1);
        let v5 = &mut v4;
        set_display_fields(v5);
        let (v6, v7) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<BattlePass>(&v3, arg1);
        let v8 = v7;
        let v9 = v6;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<BattlePass>(&mut v9, &v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<BattlePass>(&mut v9, &v8);
        let v10 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<BattlePass>(&v3);
        let v11 = 0x1::vector::empty<address>();
        let v12 = &mut v11;
        0x1::vector::push_back<address>(v12, @0x682538722619c5cb38ae1fec6720339d376c20579c9fda26b7686e1317505da5);
        0x1::vector::push_back<address>(v12, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v13 = 0x1::vector::empty<u16>();
        let v14 = &mut v13;
        0x1::vector::push_back<u16>(v14, 9500);
        0x1::vector::push_back<u16>(v14, 500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<BattlePass>(v10, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v11, v13), arg1), 300, arg1);
        let (v15, v16) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<BattlePass>(&v3, arg1);
        let v17 = v16;
        let v18 = v15;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::enforce<BattlePass, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>(&mut v18, &v17);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<BattlePass, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new<BattlePass, 0x2::sui::SUI>(v10, &v9, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::no_protection(), arg1));
        let v19 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BattlePass>>(v1, v19);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v19);
        0x2::transfer::public_transfer<0x2::display::Display<BattlePass>>(v4, v19);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BattlePass>>(v8, v19);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v17, v19);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<BattlePass>>(v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BattlePass>>(v9);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<BattlePass, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v18);
    }

    public fun lock_updates(arg0: &mut BattlePass) {
        arg0.in_game = false;
    }

    public fun mint(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BattlePass>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : BattlePass {
        assert!(arg3 <= arg4, 2);
        let v0 = BattlePass{
            id               : 0x2::object::new(arg10),
            description      : arg1,
            image_url        : arg2,
            level            : arg3,
            level_cap        : arg4,
            xp               : arg5,
            xp_to_next_level : arg6,
            rarity           : arg7,
            season           : arg8,
            in_game          : arg9,
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<BattlePass>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<BattlePass, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<BattlePass>(arg0), &v0);
        v0
    }

    public fun mint_default(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BattlePass>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : BattlePass {
        mint(arg0, arg1, arg2, 1, arg3, 0, arg4, arg5, arg6, arg7, arg8)
    }

    public fun mint_default_to_launchpad(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BattlePass>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<BattlePass>, arg8: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<BattlePass>(arg7, mint_default(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg8));
    }

    public fun mint_to_launchpad(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BattlePass>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<BattlePass>, arg10: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<BattlePass>(arg9, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, false, arg10));
    }

    fun set_display_fields(arg0: &mut 0x2::display::Display<BattlePass>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level_cap"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"xp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"xp_to_next_level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"season"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Battle Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level_cap}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{xp}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{xp_to_next_level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{season}"));
        0x2::display::add_multiple<BattlePass>(arg0, v0, v2);
    }

    public fun unlock_updates(arg0: &mut BattlePass, arg1: UnlockUpdatesTicket) {
        assert!(arg1.battle_pass_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        arg0.in_game = true;
        let UnlockUpdatesTicket {
            id             : v0,
            battle_pass_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun update(arg0: &mut BattlePass, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0.in_game, 1);
        assert!(arg1 <= arg0.level_cap, 2);
        arg0.level = arg1;
        arg0.xp = arg2;
        arg0.xp_to_next_level = arg3;
    }

    // decompiled from Move bytecode v6
}

