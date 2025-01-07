module 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::enforcer_machin_prototypes_01 {
    struct ENFORCER_MACHIN_PROTOTYPES_01 has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Emp has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun airdrop_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Emp>, arg13: &mut 0x2::kiosk::Kiosk, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Emp>(arg13, v0, arg14);
    }

    public entry fun airdrop_nft_into_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Emp>, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg13, arg14);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Emp>(&mut v3, v0, arg14);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun burn_nft(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Emp>, arg2: Emp) {
        let Emp {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Emp>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Emp>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Emp>(arg0), &arg2), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Emp>>(arg1), v0);
    }

    public entry fun burn_nft_in_listing(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Emp>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft(arg0, arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<Emp>(arg2, arg3, arg4));
    }

    public entry fun burn_nft_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Emp>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_nft(arg0, arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<Emp>(arg2, arg3, arg4, arg5));
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Emp, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Emp, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Emp>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Emp, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Emp, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Emp>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: ENFORCER_MACHIN_PROTOTYPES_01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<ENFORCER_MACHIN_PROTOTYPES_01, Emp>(&arg0, 0x1::option::some<u64>(1333), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<ENFORCER_MACHIN_PROTOTYPES_01>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"Utility"));
        let v5 = 0x2::display::new<Emp>(&v3, arg1);
        0x2::display::add<Emp>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Emp>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Emp>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Emp>(&mut v5, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Emp>(&mut v5, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v4));
        0x2::display::update_version<Emp>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Emp>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Emp, Witness>(v6);
        let v8 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v8, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Emp, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(v8));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Emp, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Enforcer Machin Prototypes 01"), 0x1::string::utf8(b"Designed by the Triangle Company, 3,333 Enforcer Machin are here to retake the city of Nozomi from the Tamashi. Start assembling your army of Enforcers by minting a Prototype, which can be later upgraded to an Enforcer Machin dNFT complete with trait-swapping and leveling-up abilities. In Phase 1 of our 3-phase mint, 1,333 Enforcer Prototypes will be available.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Emp, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"EMP10")));
        let v9 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v9, @0x585fff81dad10fc7fcdba55a815557ba263185b49307285002852e9fa981451d, 9500);
        0x2::vec_map::insert<address, u16>(&mut v9, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f, 500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Emp>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(v9, arg1), 500, arg1);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Emp>(&v3, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Emp>(&mut v13, &v12);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Emp>(&mut v13, &v12);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Emp, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Emp, 0x2::sui::SUI>(v7, &v13, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Emp>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Emp>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Emp>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Emp>>(v13);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Emp>, arg13: &mut 0x2::tx_context::TxContext) : Emp {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"ArmLeft"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"ArmRight"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Background"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Chest"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Headwear"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Internals"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Powerpack"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Screen"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"Skin"));
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, arg3);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg4);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg5);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg6);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg7);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg8);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg9);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg10);
        0x1::vector::push_back<0x1::ascii::String>(v3, arg11);
        let v4 = Emp{
            id          : 0x2::object::new(arg13),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v0, v2),
        };
        let v5 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg13);
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::arm_left::ArmLeft, Witness>(v6, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::arm_left::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg3)), arg13));
        let v7 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::arm_right::ArmRight, Witness>(v7, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::arm_right::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg4)), arg13));
        let v8 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::background::Background, Witness>(v8, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::background::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg5)), arg13));
        let v9 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::chest::Chest, Witness>(v9, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::chest::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg6)), arg13));
        let v10 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::headwear::Headwear, Witness>(v10, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::headwear::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg7)), arg13));
        let v11 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::internals::Internals, Witness>(v11, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::internals::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg8)), arg13));
        let v12 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::powerpack::Powerpack, Witness>(v12, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::powerpack::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg9)), arg13));
        let v13 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::screen::Screen, Witness>(v13, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::screen::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg10)), arg13));
        let v14 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::skin::Skin, Witness>(v14, &mut v5, 0x71ef69d02e77dff830c7de41db1452928c8ecd9040a541eef6729f139df83ffd::skin::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg11)), arg13));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v4.id, v5);
        let v15 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Emp>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Emp, Witness>(v15), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Emp>(arg12), &v4);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Emp>(arg12, 1);
        v4
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Emp>, arg13: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Emp>, arg14: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Emp>(arg13, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14));
    }

    // decompiled from Move bytecode v6
}

