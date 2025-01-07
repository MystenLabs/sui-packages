module 0x77d754d1f80b1623b9ca66a30ff55503f6b9369c020f3548273f3199e89d2077::mockghost_with_royalty {
    struct MOCKGHOST_WITH_ROYALTY has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MockGhost has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct MockGhostMetadata has store, key {
        id: 0x2::object::UID,
        name: vector<0x1::string::String>,
        url: vector<0x1::string::String>,
        mint_count: vector<u64>,
        attribute_key: 0x1::ascii::String,
        attribute_value: vector<0x1::ascii::String>,
    }

    public entry fun disable_orderbook<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<MockGhost, T0>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::disable_orderbook<MockGhost, T0>(arg0, arg1);
    }

    public entry fun enable_orderbook<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<MockGhost, T0>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::enable_orderbook<MockGhost, T0>(arg0, arg1);
    }

    public entry fun delete_mint_cap(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockGhost>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::delete_mint_cap<MockGhost>(arg0);
    }

    fun init(arg0: MOCKGHOST_WITH_ROYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<MOCKGHOST_WITH_ROYALTY, MockGhost>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<MOCKGHOST_WITH_ROYALTY>(arg0, arg1);
        let v5 = 0x2::display::new<MockGhost>(&v4, arg1);
        0x2::display::add<MockGhost>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MockGhost>(&mut v5, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<MockGhost>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MockGhost>>(v5, v0);
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockGhost, Witness>(v6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<MockGhost, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"MockGhost"), 0x1::string::utf8(b"Mock Ghost collection on Sui")));
        let v8 = vector[@0x29dbaef556d2abdb865652ba4e4a7e850c730d7b493e81c61c355ee218185484, @0x8ce11575d910ddd8bf5d8bec616623de58dcc7249f812ecc47551b9593a32682];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<MockGhost, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v8)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<MockGhost>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v8, vector[5000, 5000]), arg1), 3000, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Ghost[R30]1"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Ghost[R30]2"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Ghost[R30]3"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Ghost[R30]4"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Ghost[R30]5"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmdbGrSZSZCu8kQjuwbZGsnyopLB3KsYcqWAhKNR71HgDy"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://ipfs.io/ipfs/Qma1GvoZ1vhvy8vQvJ83zVRGoJeRTmucdMd3UYiqCtxZYV"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmeqbnPSsXz5he9795YyWwBtLBmXcy26kVeMaVXiMbnee8"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmS2FXySyzXCAH57m5ECDKy5UZvXX7rD1qjwMbiSFSdwv2"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmW8gxFbiXaXPGywtqLnYfn8k9Yy4mMdJKhRCbbvhJ5Lkn"));
        let v13 = 0x1::vector::empty<0x1::ascii::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::ascii::String>(v14, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v14, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v14, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v14, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v14, 0x1::ascii::string(b"R"));
        let v15 = MockGhostMetadata{
            id              : 0x2::object::new(arg1),
            name            : v9,
            url             : v11,
            mint_count      : vector[0, 0, 0, 0, 0],
            attribute_key   : 0x1::ascii::string(b"rarity"),
            attribute_value : v13,
        };
        let (v16, v17) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<MockGhost>(&v4, arg1);
        let v18 = v17;
        let v19 = v16;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<MockGhost>(&mut v19, &v18);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<MockGhost>(&mut v19, &v18);
        let (v20, v21) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<MockGhost>(&v4, arg1);
        let v22 = v21;
        let v23 = v20;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<MockGhost>(&mut v23, &v22);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockGhost>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MockGhost>>(v18, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MockGhost>>(v22, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<MockGhost>>(v3);
        0x2::transfer::public_share_object<MockGhostMetadata>(v15);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MockGhost>>(v19);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MockGhost>>(v23);
    }

    public entry fun mint_nft_to_address(arg0: u64, arg1: address, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockGhost>, arg3: &mut MockGhostMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 5, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg3.mint_count, arg0 - 1);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg3.name, arg0 - 1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, u64ToString(*v0));
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, arg3.attribute_key);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, *0x1::vector::borrow<0x1::ascii::String>(&arg3.attribute_value, arg0 - 1));
        let v4 = MockGhost{
            id         : 0x2::object::new(arg4),
            name       : v1,
            url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(0x1::vector::borrow<0x1::string::String>(&arg3.url, arg0 - 1))),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v2, v3),
        };
        let v5 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockGhost>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockGhost, Witness>(v5), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MockGhost>(arg2), &v4);
        *v0 = *v0 + 1;
        0x2::transfer::public_transfer<MockGhost>(v4, arg1);
    }

    public entry fun mint_nft_to_kiosk(arg0: u64, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockGhost>, arg3: &mut MockGhostMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 5, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg3.mint_count, arg0 - 1);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg3.name, arg0 - 1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, u64ToString(*v0));
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, arg3.attribute_key);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, *0x1::vector::borrow<0x1::ascii::String>(&arg3.attribute_value, arg0 - 1));
        let v4 = MockGhost{
            id         : 0x2::object::new(arg4),
            name       : v1,
            url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(0x1::vector::borrow<0x1::string::String>(&arg3.url, arg0 - 1))),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v2, v3),
        };
        let v5 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockGhost>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockGhost, Witness>(v5), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MockGhost>(arg2), &v4);
        *v0 = *v0 + 1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<MockGhost>(arg1, v4, arg4);
    }

    public entry fun split_and_transfer_mint_cap(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockGhost>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockGhost>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<MockGhost>(arg0, arg1, arg3), arg2);
    }

    fun u64ToString(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
                arg0 = arg0 / 10;
            };
            0x1::vector::reverse<u8>(&mut v0);
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

