module 0xa2854c5e804d211e8addea1533d2a8dccf5fd91a8cfe71d168944c8a96fa4ed0::nftt {
    struct NFTT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Nftt has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        chapter: u64,
        chapter_name: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Nftt, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Nftt, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Nftt>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Nftt, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Nftt, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Nftt>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: NFTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<NFTT, Nftt>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::package::claim<NFTT>(arg0, arg1);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v7 = 0x2::display::new<Nftt>(&v5, arg1);
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"chapter_name"), 0x1::string::utf8(b"{chapter_name}"));
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v6));
        0x2::display::add<Nftt>(&mut v7, 0x1::string::utf8(b"creators"), 0x1::string::utf8(b"NFTT Movers"));
        0x2::display::update_version<Nftt>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<Nftt>>(v7, 0x2::tx_context::sender(arg1));
        let v8 = Witness{dummy_field: false};
        let v9 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Nftt, Witness>(v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Nftt, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v9, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"NFTT"), 0x1::string::utf8(b"Time is the canvas upon which the origin of all things is painted, the starting point of every journey and the foundation upon which we build our future.")));
        let v10 = vector[@0x4b8ede24544af89bad8edb385178c920103056b7d93b293217084777dac30184, @0x5ccf0abc985c340d8d3e5b848080b6946cd479dc16b4371a9137eb6ca655b1ab];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Nftt, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v9, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Nftt>(v9, &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(vector[@0x4b8ede24544af89bad8edb385178c920103056b7d93b293217084777dac30184, @0x5ccf0abc985c340d8d3e5b848080b6946cd479dc16b4371a9137eb6ca655b1ab, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f], vector[4750, 4750, 500]), arg1), 500, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Nftt>(&v5, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Nftt>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Nftt>(&mut v14, &v13);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Nftt, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Nftt, 0x2::sui::SUI>(v9, &v14, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        let (v15, v16) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v17 = v16;
        let v18 = v15;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Witness>(&v17, &mut v18);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Witness>(&v17, &mut v18);
        let v19 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v19, 0x1::ascii::string(b"SuiDay"));
        let v20 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v20, 0x1::ascii::string(b"1"));
        let v21 = mint_nft_(0x1::string::utf8(b"SuiDay 1"), 0x1::string::utf8(b"Wednesday, May 3, 2023. Your origin story is not your destination - it's merely the starting point of your journey to greatness."), 1, 0x1::string::utf8(b"Suitime, Chapter 1 : The Origin"), b"ipfs://QmNRvCLcZt4DySm5Sa1etguP5DQ58uN9d9hhcVDxWvv48R?filename=NFTT-SuiDay1.png", v19, v20, &v3, arg1);
        let (v22, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(@0x4b8ede24544af89bad8edb385178c920103056b7d93b293217084777dac30184, arg1);
        let v24 = v22;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Nftt>(&mut v24, v21, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Nftt>>(v3, v0);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v17, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nftt>>(v13, v0);
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v18);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v24);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Nftt>>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nftt>>(v14);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Nftt>, arg8: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Nftt>, arg9: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Nftt>(arg8, mint_nft_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9));
    }

    public fun mint_nft_(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Nftt>, arg8: &mut 0x2::tx_context::TxContext) : Nftt {
        let v0 = Witness{dummy_field: false};
        let v1 = Nftt{
            id           : 0x2::object::new(arg8),
            name         : arg0,
            description  : arg1,
            chapter      : arg2,
            chapter_name : arg3,
            url          : 0x2::url::new_unsafe_from_bytes(arg4),
            attributes   : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg5, arg6),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Nftt>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Nftt, Witness>(v0), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Nftt>(arg7), &v1);
        v1
    }

    public entry fun mint_nft_into_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Nftt>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg8) == @0x4b8ede24544af89bad8edb385178c920103056b7d93b293217084777dac30184 || 0x2::kiosk::owner(arg8) == @0x5ccf0abc985c340d8d3e5b848080b6946cd479dc16b4371a9137eb6ca655b1ab, 0);
        let v0 = mint_nft_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Nftt>(arg8, v0, arg9);
    }

    // decompiled from Move bytecode v6
}

