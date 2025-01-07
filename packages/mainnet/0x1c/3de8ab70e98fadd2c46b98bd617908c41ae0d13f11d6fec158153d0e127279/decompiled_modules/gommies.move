module 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::gommies {
    struct GOMMIES has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Gom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun airdrop_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gom>, arg10: &mut 0x2::kiosk::Kiosk, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Gom>(arg10, v0, arg11);
    }

    public entry fun airdrop_nft_into_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gom>, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg10, arg11);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Gom>(&mut v3, v0, arg11);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public fun burn_nft(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Gom>, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Gom>, arg2: Gom) {
        let Gom {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Gom>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Gom>(arg0, &arg2), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Gom>>(arg1), v0);
    }

    public entry fun burn_nft_in_listing(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Gom>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gom>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft<Gom>(arg2, arg3, arg4));
    }

    public entry fun burn_nft_in_listing_with_id(arg0: &0x2::package::Publisher, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Gom>, arg2: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        burn_nft(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gom>(arg0), arg1, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::admin_redeem_nft_with_id<Gom>(arg2, arg3, arg4, arg5));
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Gom, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Gom, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gom>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Gom, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Gom, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gom>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: GOMMIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<GOMMIES, Gom>(&arg0, 0x1::option::some<u64>(5000), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<GOMMIES>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        let v5 = 0x2::display::new<Gom>(&v3, arg1);
        0x2::display::add<Gom>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Gom>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Gom>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Gom>(&mut v5, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Gom>(&mut v5, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v4));
        0x2::display::update_version<Gom>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Gom>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Gom, Witness>(v6);
        let v8 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v8, @0x819545cf10e4b2a8dd88a119d7d035cbd3a0f793f1f438c900d94d0a0c2e8b9c);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Gom, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(v8));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Gom, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Gommies"), 0x1::string::utf8(b"Gommies is more than just an NFT project. It's a movement that is redefining the way we think about digital collectibles.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Gom, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"GOM")));
        let v9 = 0x2::vec_map::empty<address, u16>();
        0x2::vec_map::insert<address, u16>(&mut v9, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f, 250);
        0x2::vec_map::insert<address, u16>(&mut v9, @0x819545cf10e4b2a8dd88a119d7d035cbd3a0f793f1f438c900d94d0a0c2e8b9c, 9750);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Gom>(v7, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(v9, arg1), 500, arg1);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Gom>(&v3, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Gom>(&mut v13, &v12);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Gom>(&mut v13, &v12);
        let (v14, v15) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::init_policy<Gom>(&v3, arg1);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Gom, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Gom, 0x2::sui::SUI>(v7, &v13, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gom>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Gom>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Gom>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Gom>>(v13);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v15, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Gom, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>>(v14);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gom>, arg10: &mut 0x2::tx_context::TxContext) : Gom {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"Background"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"Skin"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"Clothes"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"Mouth"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"Eyes"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"Head"));
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::ascii::String>(v4, arg3);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg4);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg5);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg6);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg7);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg8);
        let v5 = Gom{
            id          : 0x2::object::new(arg10),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v1, v3),
        };
        let v6 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg10);
        let v7 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::background::Background, Witness>(v7, &mut v6, 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::background::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg3)), arg10));
        let v8 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::skin::Skin, Witness>(v8, &mut v6, 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::skin::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg4)), arg10));
        let v9 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::clothes::Clothes, Witness>(v9, &mut v6, 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::clothes::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg5)), arg10));
        let v10 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::mouth::Mouth, Witness>(v10, &mut v6, 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::mouth::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg6)), arg10));
        let v11 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::eyes::Eyes, Witness>(v11, &mut v6, 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::eyes::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg7)), arg10));
        let v12 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::head::Head, Witness>(v12, &mut v6, 0x1c3de8ab70e98fadd2c46b98bd617908c41ae0d13f11d6fec158153d0e127279::head::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg8)), arg10));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v5.id, v6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Gom>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Gom, Witness>(v0), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Gom>(arg9), &v5);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Gom>(arg9, 1);
        v5
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Gom>, arg10: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Gom>, arg11: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Gom>(arg10, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11));
    }

    public entry fun set_metadata(arg0: &0x2::package::Publisher, arg1: &mut Gom, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>) {
        set_metadata_(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gom>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun set_metadata_(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Gom>, arg1: &mut Gom, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
        arg1.attributes = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4);
    }

    public entry fun set_metadata_in_kiosk(arg0: &0x2::package::Publisher, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Gom, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Gom>(arg0);
        let v1 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::borrow_nft_mut<Gom>(arg1, arg2, 0x1::option::none<0x1::type_name::TypeName>(), arg7);
        let v2 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::Witness, Gom>(v0, &mut v1);
        set_metadata_(v0, v2, arg3, arg4, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::return_nft<Witness, Gom>(arg1, v1, arg6);
    }

    // decompiled from Move bytecode v6
}

