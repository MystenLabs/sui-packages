module 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::misfits {
    struct MISFITS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Misfit has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun airdrop_nft_into_new_kiosk(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misfit>, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_nft_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg14, arg15);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Misfit>(&mut v3, v0, arg15);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Misfit, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Misfit, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Misfit>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Misfit, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Misfit, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Misfit>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: MISFITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<MISFITS, Misfit>(&arg0, 0x1::option::some<u64>(7777), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<MISFITS>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v7 = 0x2::display::new<Misfit>(&v4, arg1);
        0x2::display::add<Misfit>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Misfit>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Misfit>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Misfit>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Misfit>(&mut v7, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<Misfit>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<Misfit>>(v7, 0x2::tx_context::sender(arg1));
        let v8 = Witness{dummy_field: false};
        let v9 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Misfit, Witness>(v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Misfit, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Misfits"), 0x1::string::utf8(b"Misfits is a brand created by leveraging the power of Web3 and co-created by the community it serves.")));
        let v10 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v10, @0xce210479a727f1120bc58178ed1e6cef506f121d4c4b194b781cc0ce31448b7f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Misfit, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        let v11 = 0x1::vector::empty<address>();
        let v12 = &mut v11;
        0x1::vector::push_back<address>(v12, @0xce210479a727f1120bc58178ed1e6cef506f121d4c4b194b781cc0ce31448b7f);
        0x1::vector::push_back<address>(v12, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Misfit>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v11, vector[9500, 500]), arg1), 500, arg1);
        let (v13, v14) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Misfit>(&v4, arg1);
        let v15 = v14;
        let v16 = v13;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Misfit>(&mut v16, &v15);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Misfit>(&mut v16, &v15);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Misfit, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Misfit, 0x2::sui::SUI>(v9, &v16, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        let (v17, v18) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v19 = v18;
        let v20 = v17;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Witness>(&v19, &mut v20);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Witness>(&v19, &mut v20);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misfit>>(v2, v0);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v19, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Misfit>>(v15, v0);
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v20);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Misfit>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Misfit>>(v16);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misfit>, arg14: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<Misfit>, arg15: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<Misfit>(arg14, mint_nft_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15));
    }

    fun mint_nft_(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Misfit>, arg14: &mut 0x2::tx_context::TxContext) : Misfit {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"background"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"clothing"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"eyes"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"mouth"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"facial_hair"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"facewear"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"accessories"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"headwear"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"companion"));
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x1::ascii::string(b"1/1"));
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::ascii::String>(v4, arg3);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg7);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg4);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg5);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg6);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg9);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg10);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg8);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg11);
        0x1::vector::push_back<0x1::ascii::String>(v4, arg12);
        let v5 = Misfit{
            id          : 0x2::object::new(arg14),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v1, v3),
        };
        let v6 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::new(arg14);
        let v7 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::background::Background, Witness>(v7, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::background::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg3)), arg14));
        let v8 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::clothing::Clothing, Witness>(v8, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::clothing::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg7)), arg14));
        let v9 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::eyes::Eyes, Witness>(v9, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::eyes::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg4)), arg14));
        let v10 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::mouth::Mouth, Witness>(v10, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::mouth::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg5)), arg14));
        let v11 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::facial_hair::FacialHair, Witness>(v11, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::facial_hair::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg6)), arg14));
        let v12 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::facewear::Facewear, Witness>(v12, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::facewear::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg9)), arg14));
        let v13 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::accessories::Accessory, Witness>(v13, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::accessories::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg10)), arg14));
        let v14 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::headwear::Headwear, Witness>(v14, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::headwear::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg8)), arg14));
        let v15 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::compose<0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::companion::Companion, Witness>(v15, &mut v6, 0xecc57f49718c452eed9aa3d5f8ed83910c0ec56ad19c8ab62c741bd3e55a7d3a::companion::mint_(0x1::string::utf8(0x1::ascii::into_bytes(arg11)), arg14));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Misfit>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Misfit, Witness>(v0), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Misfit>(arg13), &v5);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_bag::add_domain(&mut v5.id, v6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Misfit>(arg13, 1);
        v5
    }

    // decompiled from Move bytecode v6
}

