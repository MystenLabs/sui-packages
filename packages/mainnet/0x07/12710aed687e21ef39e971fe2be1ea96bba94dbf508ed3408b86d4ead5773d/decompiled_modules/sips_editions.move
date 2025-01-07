module 0x712710aed687e21ef39e971fe2be1ea96bba94dbf508ed3408b86d4ead5773d::sips_editions {
    struct SIPS_EDITIONS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Sips_editions has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public fun burn_nft(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>, arg1: Sips_editions) {
        let v0 = Witness{dummy_field: false};
        let Sips_editions {
            id          : v1,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg1;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Sips_editions>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Sips_editions>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sips_editions, Witness>(v0), &arg1), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>>(arg0), v1);
    }

    public entry fun burn_nft_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Sips_editions, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<Sips_editions>(arg1, arg2, arg4);
        let v2 = v1;
        let v3 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<Sips_editions, Witness>(&mut v2, &v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<Sips_editions>(v2, arg3);
        burn_nft(arg0, v0);
    }

    public entry fun burn_nft_in_listing(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        burn_nft(arg0, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<Sips_editions>(arg1, arg2, arg3));
    }

    public entry fun burn_nft_in_listing_with_id(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft(arg0, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<Sips_editions>(arg1, arg2, arg3, arg4));
    }

    fun init(arg0: SIPS_EDITIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sips_editions, Witness>(v0);
        let v2 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create<Sips_editions>(v1, arg1);
        let v3 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v3, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Sips_editions, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(v3));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Sips_editions, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Sips Editions"), 0x1::string::utf8(b"Various editions for Sips. A true Sipizen collects them all!")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Sips_editions, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"SIPSE")));
        let v4 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v4, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f, 500);
        0x2::vec_map::insert<address, u16>(&mut v4, @0x174d523be66c291225bb1c9c283aed9aeb9e7ae737e616ffe3b723919c749333, 9500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Sips_editions>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(v4, arg1), 1000, arg1);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>>(v2);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sips_editions>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<SIPS_EDITIONS, Sips_editions>(&arg0, 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Sips_editions>>(&v2), arg1), 0x2::tx_context::sender(arg1));
        let v5 = 0x2::package::claim<SIPS_EDITIONS>(arg0, arg1);
        let v6 = 0x2::display::new<Sips_editions>(&v5, arg1);
        0x2::display::add<Sips_editions>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Sips_editions>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Sips_editions>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Sips_editions>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"Utility"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"Art"));
        0x2::display::add<Sips_editions>(&mut v6, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v7));
        0x2::display::update_version<Sips_editions>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Sips_editions>>(v6, 0x2::tx_context::sender(arg1));
        let (v8, v9) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Sips_editions>(&v5, arg1);
        let v10 = v9;
        let v11 = v8;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Sips_editions>(&mut v11, &v10);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Sips_editions>(&mut v11, &v10);
        let (v12, v13) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Sips_editions>(&v5, arg1);
        let v14 = v13;
        let v15 = v12;
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Sips_editions, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>, Witness>(&mut v15, &v14);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Sips_editions, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Sips_editions, 0x2::sui::SUI>(v1, &v11, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Sips_editions>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Sips_editions>>(v11);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Sips_editions, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v15);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sips_editions>, arg6: &mut 0x2::tx_context::TxContext) : Sips_editions {
        let v0 = Witness{dummy_field: false};
        let v1 = Sips_editions{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Sips_editions>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Sips_editions, Witness>(v0), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Sips_editions>(arg5), &v1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Sips_editions>(arg5, 1);
        v1
    }

    public entry fun mint_nft_to_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sips_editions>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Sips_editions>(arg6, v0, arg7);
    }

    public entry fun mint_nft_to_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sips_editions>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg6, arg7);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Sips_editions>(&mut v3, v0, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun mint_nft_to_warehouse(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Sips_editions>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Sips_editions>, arg7: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Sips_editions>(arg6, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    // decompiled from Move bytecode v6
}

