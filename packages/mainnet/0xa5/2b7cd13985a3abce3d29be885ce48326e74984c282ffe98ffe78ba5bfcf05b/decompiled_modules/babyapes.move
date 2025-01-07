module 0xa52b7cd13985a3abce3d29be885ce48326e74984c282ffe98ffe78ba5bfcf05b::babyapes {
    struct BABYAPES has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct BabyApeNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<BabyApeNft, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<BabyApeNft, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<BabyApeNft>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<BabyApeNft, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<BabyApeNft, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<BabyApeNft>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    fun init(arg0: BABYAPES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<BABYAPES, BabyApeNft>(&arg0, 0x1::option::some<u64>(3000), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<BABYAPES>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v7 = 0x2::display::new<BabyApeNft>(&v4, arg1);
        0x2::display::add<BabyApeNft>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BabyApeNft>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<BabyApeNft>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<BabyApeNft>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<BabyApeNft>(&mut v7, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<BabyApeNft>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<BabyApeNft>>(v7, 0x2::tx_context::sender(arg1));
        let v8 = Witness{dummy_field: false};
        let v9 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<BabyApeNft, Witness>(v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<BabyApeNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Baby Ape Society"), 0x1::string::utf8(b"Babyapessociety are a limited and rare collection of 2500 PFPs on the SUI blockchain that are invading the real world. Become a babyapessociety holder and unlock real-world utility with your NFT and access the one-of-a-kind babyapessociety Nation community. So, where will your babyapessociety journey lead you?")));
        let v10 = 0x1::vector::empty<address>();
        let v11 = &mut v10;
        0x1::vector::push_back<address>(v11, @0x1f9d9ba4f1db14c26424fce755b3b3bf002ad0f77870a46bdadefba00fbfe6d9);
        0x1::vector::push_back<address>(v11, @0x2eb56269799227490ef69cd4b226cc23cee42df9d2d2f5c7b3d0eb18a37067a2);
        0x1::vector::push_back<address>(v11, @0xf80170aa575ed48b1f500e92ad6c9c038e6cff4260a366612a77c6d9303e5971);
        0x1::vector::push_back<address>(v11, @0xd458b7ac5884e31b4eccf97d39cbf60ba1de0e8b4b1998bdc0f347236badf355);
        0x1::vector::push_back<address>(v11, @0x88e524ab243fe567899534f4a7015f58ee501e64dfbe3c67828350c3ac4f3769);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<BabyApeNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        let v12 = 0x1::vector::empty<address>();
        let v13 = &mut v12;
        0x1::vector::push_back<address>(v13, @0x1f9d9ba4f1db14c26424fce755b3b3bf002ad0f77870a46bdadefba00fbfe6d9);
        0x1::vector::push_back<address>(v13, @0x2eb56269799227490ef69cd4b226cc23cee42df9d2d2f5c7b3d0eb18a37067a2);
        0x1::vector::push_back<address>(v13, @0xf80170aa575ed48b1f500e92ad6c9c038e6cff4260a366612a77c6d9303e5971);
        0x1::vector::push_back<address>(v13, @0xd458b7ac5884e31b4eccf97d39cbf60ba1de0e8b4b1998bdc0f347236badf355);
        0x1::vector::push_back<address>(v13, @0x88e524ab243fe567899534f4a7015f58ee501e64dfbe3c67828350c3ac4f3769);
        0x1::vector::push_back<address>(v13, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f);
        let v14 = 0x1::vector::empty<u16>();
        let v15 = &mut v14;
        0x1::vector::push_back<u16>(v15, 1900);
        0x1::vector::push_back<u16>(v15, 1900);
        0x1::vector::push_back<u16>(v15, 1900);
        0x1::vector::push_back<u16>(v15, 1900);
        0x1::vector::push_back<u16>(v15, 1900);
        0x1::vector::push_back<u16>(v15, 500);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<BabyApeNft>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v12, v14), arg1), 500, arg1);
        let (v16, v17) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<BabyApeNft>(&v4, arg1);
        let v18 = v17;
        let v19 = v16;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<BabyApeNft>(&mut v19, &v18);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<BabyApeNft>(&mut v19, &v18);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<BabyApeNft, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<BabyApeNft, 0x2::sui::SUI>(v9, &v19, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BabyApeNft>>(v2, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BabyApeNft>>(v18, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<BabyApeNft>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BabyApeNft>>(v19);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BabyApeNft>, arg6: &mut 0x2::tx_context::TxContext) : BabyApeNft {
        let v0 = BabyApeNft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<BabyApeNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<BabyApeNft, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<BabyApeNft>(arg5), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<BabyApeNft>(arg5, 1);
        v0
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<BabyApeNft>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<BabyApeNft>, arg7: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<BabyApeNft>(arg6, mint(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    // decompiled from Move bytecode v6
}

