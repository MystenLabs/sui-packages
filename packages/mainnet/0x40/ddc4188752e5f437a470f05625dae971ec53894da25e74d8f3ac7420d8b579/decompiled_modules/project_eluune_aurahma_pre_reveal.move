module 0x40ddc4188752e5f437a470f05625dae971ec53894da25e74d8f3ac7420d8b579::project_eluune_aurahma_pre_reveal {
    struct PROJECT_ELUUNE_AURAHMA_PRE_REVEAL has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct AurahmaPreReveal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public fun burn_nft(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<AurahmaPreReveal>, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg2: AurahmaPreReveal) {
        let AurahmaPreReveal {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<AurahmaPreReveal>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<AurahmaPreReveal>(arg0, &arg2), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>>(arg1), v0);
        let v5 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::borrow_domain_mut<AurahmaPreReveal>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<AurahmaPreReveal>(arg0, arg1));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::decrement<AurahmaPreReveal>(arg0, v5, 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::decrease_supply_ceil<AurahmaPreReveal>(arg0, v5, 1);
    }

    public entry fun burn_nft_in_listing(arg0: &0x2::package::Publisher, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<AurahmaPreReveal>(arg2, arg3, arg4));
    }

    public entry fun burn_nft_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<AurahmaPreReveal>(arg2, arg3, arg4, arg5));
    }

    public entry fun burn_own_nft(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg1: AurahmaPreReveal) {
        let v0 = Witness{dummy_field: false};
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaPreReveal, Witness>(v0), arg0, arg1);
    }

    public entry fun burn_own_nft_in_kiosk(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<AurahmaPreReveal>(arg1, arg2, arg4);
        let v2 = v1;
        let v3 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<AurahmaPreReveal, Witness>(&mut v2, &v3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<AurahmaPreReveal>(v2, arg3);
        burn_own_nft(arg0, v0);
    }

    fun init(arg0: PROJECT_ELUUNE_AURAHMA_PRE_REVEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaPreReveal, Witness>(v0);
        let v2 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create<AurahmaPreReveal>(v1, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_limited<PROJECT_ELUUNE_AURAHMA_PRE_REVEAL, AurahmaPreReveal>(&arg0, 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>>(&v2), 600, arg1), 0x2::tx_context::sender(arg1));
        let v3 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v3, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(v3));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Project Eluune: Aurahma Pre-Reveal"), 0x1::string::utf8(b"Project Eluune is a gaming sci-fi fantasy universe brought to you by OG game veterans who built Call Of Duty, Dota2 and many of your favorite video games. As a player, you answer the call of Eluune, a mysterious entity who has sent an SOS message to us humans from a hidden world... Techno-magical, teeming with fantastic life and rich secrecy spanning millions of years... Will you answer the call?")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"PRAMA")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::Supply<AurahmaPreReveal>>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::new<AurahmaPreReveal>(v1, 600, false));
        let v4 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v4, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f, 500);
        0x2::vec_map::insert<address, u16>(&mut v4, @0x8212bb78cc5c42f95766107573147d79b0954fe06e52f54f27e26677b43c88f5, 9500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<AurahmaPreReveal>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(v4, arg1), 700, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"Gaming"));
        let v6 = 0x2::package::claim<PROJECT_ELUUNE_AURAHMA_PRE_REVEAL>(arg0, arg1);
        let (v7, v8) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<AurahmaPreReveal>(&v6, arg1);
        let v9 = v8;
        let v10 = v7;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<AurahmaPreReveal>(&mut v10, &v9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<AurahmaPreReveal>(&mut v10, &v9);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<AurahmaPreReveal>(&v6, arg1);
        let (v13, v14) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<AurahmaPreReveal>(&v6, arg1);
        let v15 = v14;
        let v16 = v13;
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>, Witness>(&mut v16, &v15);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<AurahmaPreReveal, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<AurahmaPreReveal, 0x2::sui::SUI>(v1, &v10, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>>(v2);
        let v17 = 0x2::display::new<AurahmaPreReveal>(&v6, arg1);
        0x2::display::add<AurahmaPreReveal>(&mut v17, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AurahmaPreReveal>(&mut v17, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AurahmaPreReveal>(&mut v17, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<AurahmaPreReveal>(&mut v17, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<AurahmaPreReveal>(&mut v17, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<AurahmaPreReveal>(&mut v17);
        0x2::transfer::public_transfer<0x2::display::Display<AurahmaPreReveal>>(v17, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<AurahmaPreReveal>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<AurahmaPreReveal>>(v10);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v15, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v16);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v11);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg7: &mut 0x2::tx_context::TxContext) : AurahmaPreReveal {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaPreReveal, Witness>(v0);
        let v2 = AurahmaPreReveal{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<AurahmaPreReveal>(v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<AurahmaPreReveal>(arg5), &v2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::increment<AurahmaPreReveal>(v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::supply::borrow_domain_mut<AurahmaPreReveal>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<AurahmaPreReveal>(v1, arg6)), 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<AurahmaPreReveal>(arg5, 1);
        v2
    }

    public entry fun mint_nft_to_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<AurahmaPreReveal>(arg7, v0, arg8);
    }

    public entry fun mint_nft_to_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg7, arg8);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<AurahmaPreReveal>(&mut v3, v0, arg8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun mint_nft_to_warehouse(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg7: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<AurahmaPreReveal>, arg8: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<AurahmaPreReveal>(arg7, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8));
    }

    public fun set_metadata(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<AurahmaPreReveal>, arg1: &mut AurahmaPreReveal, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
        arg1.attributes = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4);
    }

    public entry fun set_metadata_as_publisher(arg0: &0x2::package::Publisher, arg1: &mut AurahmaPreReveal, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>) {
        set_metadata(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, arg2, arg3, arg4);
    }

    public entry fun set_metadata_in_kiosk(arg0: &0x2::package::Publisher, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0);
        let v1 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<AurahmaPreReveal>(arg1, arg2, 0x1::option::none<0x1::type_name::TypeName>(), arg7);
        let v2 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, AurahmaPreReveal>(v0, &mut v1);
        set_metadata(v0, v2, arg3, arg4, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, AurahmaPreReveal>(arg1, v1, arg6);
    }

    // decompiled from Move bytecode v6
}

