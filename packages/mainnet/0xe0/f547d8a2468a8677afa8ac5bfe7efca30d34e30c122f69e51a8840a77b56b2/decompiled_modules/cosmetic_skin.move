module 0xe0f547d8a2468a8677afa8ac5bfe7efca30d34e30c122f69e51a8840a77b56b2::cosmetic_skin {
    struct COSMETIC_SKIN has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct CosmeticSkin has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        level: u64,
        level_cap: u64,
        in_game: bool,
    }

    struct UnlockUpdatesTicket has store, key {
        id: 0x2::object::UID,
        cosmetic_skin_id: 0x2::object::ID,
    }

    public fun create_unlock_updates_ticket(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CosmeticSkin>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : UnlockUpdatesTicket {
        UnlockUpdatesTicket{
            id               : 0x2::object::new(arg2),
            cosmetic_skin_id : arg1,
        }
    }

    public fun export_to_kiosk(arg0: CosmeticSkin, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_is_ob_kiosk(arg1);
        arg0.in_game = false;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<CosmeticSkin>(arg1, arg0, arg2);
    }

    public fun import_cosmetic_skin_to_cw(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::TransferToken<CosmeticSkin>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<CosmeticSkin, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<CosmeticSkin>(arg1, arg2, arg4);
        let v2 = v1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::confirm<CosmeticSkin, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>(v0, arg0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::inner_mut<CosmeticSkin>(&mut v2));
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<CosmeticSkin>(v2, arg3);
    }

    fun init(arg0: COSMETIC_SKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<COSMETIC_SKIN, CosmeticSkin>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<COSMETIC_SKIN>(arg0, arg1);
        let v4 = 0x2::display::new<CosmeticSkin>(&v3, arg1);
        let v5 = &mut v4;
        set_display_fields(v5);
        let (v6, v7) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<CosmeticSkin>(&v3, arg1);
        let v8 = v7;
        let v9 = v6;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<CosmeticSkin>(&mut v9, &v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<CosmeticSkin>(&mut v9, &v8);
        let v10 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<CosmeticSkin>(&v3);
        let v11 = 0x1::vector::empty<address>();
        let v12 = &mut v11;
        0x1::vector::push_back<address>(v12, @0x4f9dbfc5ee4a994987e810fa451cba0688f61d747ac98d091dbbadee50337c3b);
        0x1::vector::push_back<address>(v12, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v13 = 0x1::vector::empty<u16>();
        let v14 = &mut v13;
        0x1::vector::push_back<u16>(v14, 9500);
        0x1::vector::push_back<u16>(v14, 500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<CosmeticSkin>(v10, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v11, v13), arg1), 300, arg1);
        let (v15, v16) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<CosmeticSkin>(&v3, arg1);
        let v17 = v16;
        let v18 = v15;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token::enforce<CosmeticSkin, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>(&mut v18, &v17);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<CosmeticSkin, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new<CosmeticSkin, 0x2::sui::SUI>(v10, &v9, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::no_protection(), arg1));
        let v19 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CosmeticSkin>>(v1, v19);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v19);
        0x2::transfer::public_transfer<0x2::display::Display<CosmeticSkin>>(v4, v19);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CosmeticSkin>>(v8, v19);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v17, v19);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<CosmeticSkin>>(v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CosmeticSkin>>(v9);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<CosmeticSkin, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v18);
    }

    public fun lock_updates(arg0: &mut CosmeticSkin) {
        arg0.in_game = false;
    }

    public fun mint(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CosmeticSkin>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CosmeticSkin {
        assert!(arg4 <= arg5, 2);
        let v0 = CosmeticSkin{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            level       : arg4,
            level_cap   : arg5,
            in_game     : false,
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<CosmeticSkin>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<CosmeticSkin, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<CosmeticSkin>(arg0), &v0);
        v0
    }

    public fun mint_to_launchpad(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CosmeticSkin>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<CosmeticSkin>, arg7: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<CosmeticSkin>(arg6, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    fun set_display_fields(arg0: &mut 0x2::display::Display<CosmeticSkin>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level_cap"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level_cap}"));
        0x2::display::add_multiple<CosmeticSkin>(arg0, v0, v2);
    }

    public fun unlock_updates(arg0: &mut CosmeticSkin, arg1: UnlockUpdatesTicket) {
        assert!(arg1.cosmetic_skin_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        arg0.in_game = true;
        let UnlockUpdatesTicket {
            id               : v0,
            cosmetic_skin_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun update(arg0: &mut CosmeticSkin, arg1: u64) {
        assert!(arg0.in_game, 1);
        assert!(arg1 <= arg0.level_cap, 2);
        arg0.level = arg1;
    }

    // decompiled from Move bytecode v6
}

