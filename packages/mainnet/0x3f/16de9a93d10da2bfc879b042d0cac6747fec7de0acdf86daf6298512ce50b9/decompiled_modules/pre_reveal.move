module 0x3f16de9a93d10da2bfc879b042d0cac6747fec7de0acdf86daf6298512ce50b9::pre_reveal {
    struct PRE_REVEAL has drop {
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

    public entry fun airdrop_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<AurahmaPreReveal>(arg6, v0, arg7);
    }

    public entry fun airdrop_nft_into_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg6, arg7);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<AurahmaPreReveal>(&mut v3, v0, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public fun burn_nft(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<AurahmaPreReveal>, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg2: AurahmaPreReveal) {
        let AurahmaPreReveal {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<AurahmaPreReveal>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<AurahmaPreReveal>(arg0, &arg2), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>>(arg1), v0);
    }

    public entry fun burn_nft_in_listing(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<AurahmaPreReveal>(arg2, arg3, arg4));
    }

    public entry fun burn_nft_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<AurahmaPreReveal>(arg2, arg3, arg4, arg5));
    }

    public entry fun burn_own_nft(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg1: AurahmaPreReveal) {
        let v0 = Witness{dummy_field: false};
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaPreReveal, Witness>(v0), arg0, arg1);
    }

    public entry fun burn_own_nft_in_kiosk(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<AurahmaPreReveal>(arg1, arg2, arg4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<AurahmaPreReveal>(v1, arg3);
        burn_own_nft(arg0, v0);
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<AurahmaPreReveal, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<AurahmaPreReveal, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<AurahmaPreReveal, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<AurahmaPreReveal, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<AurahmaPreReveal>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: PRE_REVEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<PRE_REVEAL, AurahmaPreReveal>(&arg0, 0x1::option::some<u64>(600), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<PRE_REVEAL>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"Gaming"));
        let v5 = 0x2::display::new<AurahmaPreReveal>(&v3, arg1);
        0x2::display::add<AurahmaPreReveal>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AurahmaPreReveal>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AurahmaPreReveal>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<AurahmaPreReveal>(&mut v5, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<AurahmaPreReveal>(&mut v5, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v4));
        0x2::display::update_version<AurahmaPreReveal>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<AurahmaPreReveal>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaPreReveal, Witness>(v6);
        let v8 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v8, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(v8));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Project Eluune: Aurahma Pre-Reveal"), 0x1::string::utf8(x"41757261686d612061726520706f77657266756c20737069726974732062726f7567687420746f20796f75206279204f472067616d65207665746572616e732077686f206275696c742043616c6c204f6620447574792c20446f74613220616e64206d616e79206f6620796f7572206661766f7269746520766964656f2067616d65732e0a0a41757261686d6120677569646520706c6179657273207468726f7567682050726f6a65637420456c75756e6527732067616d65732e20546865792063616e20626520757067726164656420746f20756e6c6f636b207370656369616c206162696c697469657320616e64207472616974733b20676976696e6720796f75204f472073746174757320776865726576657220796f7520676f2e")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaPreReveal, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"PRAMA")));
        let v9 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v9, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f, 500);
        0x2::vec_map::insert<address, u16>(&mut v9, @0x8212bb78cc5c42f95766107573147d79b0954fe06e52f54f27e26677b43c88f5, 9500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<AurahmaPreReveal>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(v9, arg1), 700, arg1);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<AurahmaPreReveal>(&v3, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<AurahmaPreReveal>(&mut v13, &v12);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<AurahmaPreReveal>(&mut v13, &v12);
        let (v14, v15) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<AurahmaPreReveal>(&v3, arg1);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<AurahmaPreReveal, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<AurahmaPreReveal, 0x2::sui::SUI>(v7, &v13, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaPreReveal>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<AurahmaPreReveal>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<AurahmaPreReveal>>(v13);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v15, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<AurahmaPreReveal, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v14);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0x2::tx_context::TxContext) : AurahmaPreReveal {
        let v0 = AurahmaPreReveal{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<AurahmaPreReveal>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaPreReveal, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<AurahmaPreReveal>(arg5), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<AurahmaPreReveal>(arg5, 1);
        v0
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaPreReveal>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<AurahmaPreReveal>, arg7: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<AurahmaPreReveal>(arg6, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    // decompiled from Move bytecode v6
}

