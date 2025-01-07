module 0x710a66df82df91d1b233ab6cdd64db237540709d67a67e1596566bc142814370::mockpedia {
    struct MOCKPEDIA has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MockPedia has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct MockPediaMetadata has store, key {
        id: 0x2::object::UID,
        name: vector<0x1::string::String>,
        base_url: 0x1::string::String,
        mint_count: vector<u64>,
        attribute_key: 0x1::ascii::String,
        attribute_value: vector<0x1::ascii::String>,
    }

    public entry fun disable_orderbook<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<MockPedia, T0>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::disable_orderbook<MockPedia, T0>(arg0, arg1);
    }

    public entry fun enable_orderbook<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<MockPedia, T0>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::enable_orderbook<MockPedia, T0>(arg0, arg1);
    }

    public entry fun delete_mint_cap(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockPedia>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::delete_mint_cap<MockPedia>(arg0);
    }

    fun init(arg0: MOCKPEDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<MOCKPEDIA, MockPedia>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<MOCKPEDIA>(arg0, arg1);
        let v5 = 0x2::display::new<MockPedia>(&v4, arg1);
        0x2::display::add<MockPedia>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MockPedia>(&mut v5, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<MockPedia>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MockPedia>>(v5, v0);
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<MockPedia, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockPedia, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"MockPedia"), 0x1::string::utf8(b"Mock Pedia collection on Sui")));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Name1"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Name2"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Name3"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Name4"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Name5"));
        let v9 = 0x1::vector::empty<0x1::ascii::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::ascii::String>(v10, 0x1::ascii::string(b"1R"));
        0x1::vector::push_back<0x1::ascii::String>(v10, 0x1::ascii::string(b"2R"));
        0x1::vector::push_back<0x1::ascii::String>(v10, 0x1::ascii::string(b"3R"));
        0x1::vector::push_back<0x1::ascii::String>(v10, 0x1::ascii::string(b"4R"));
        0x1::vector::push_back<0x1::ascii::String>(v10, 0x1::ascii::string(b"5R"));
        let v11 = MockPediaMetadata{
            id              : 0x2::object::new(arg1),
            name            : v7,
            base_url        : 0x1::string::utf8(b"ipfs://aaabbbccc/"),
            mint_count      : vector[0, 0, 0, 0, 0],
            attribute_key   : 0x1::ascii::string(b"rarity"),
            attribute_value : v9,
        };
        let (v12, v13) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<MockPedia>(&v4, arg1);
        let v14 = v13;
        let v15 = v12;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<MockPedia>(&mut v15, &v14);
        let (v16, v17) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<MockPedia>(&v4, arg1);
        let v18 = v17;
        let v19 = v16;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<MockPedia>(&mut v19, &v18);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockPedia>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MockPedia>>(v14, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MockPedia>>(v18, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<MockPedia>>(v3);
        0x2::transfer::public_share_object<MockPediaMetadata>(v11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MockPedia>>(v15);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MockPedia>>(v19);
    }

    public entry fun mint_nft(arg0: u64, arg1: address, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockPedia>, arg3: &mut MockPediaMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 5, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg3.mint_count, arg0 - 1);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg3.name, arg0 - 1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, u64ToString(*v0));
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, arg3.base_url);
        0x1::string::append(&mut v2, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v2, u64ToString(arg0));
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, arg3.attribute_key);
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v4, *0x1::vector::borrow<0x1::ascii::String>(&arg3.attribute_value, arg0 - 1));
        let v5 = MockPedia{
            id         : 0x2::object::new(arg4),
            name       : v1,
            url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&v2)),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v3, v4),
        };
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockPedia>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockPedia, Witness>(v6), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MockPedia>(arg2), &v5);
        *v0 = *v0 + 1;
        0x2::transfer::public_transfer<MockPedia>(v5, arg1);
    }

    public entry fun mint_nft_and_deposit(arg0: u64, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockPedia>, arg3: &mut MockPediaMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 5, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg3.mint_count, arg0 - 1);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg3.name, arg0 - 1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, u64ToString(*v0));
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, arg3.base_url);
        0x1::string::append(&mut v2, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v2, u64ToString(arg0));
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, arg3.attribute_key);
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v4, *0x1::vector::borrow<0x1::ascii::String>(&arg3.attribute_value, arg0 - 1));
        let v5 = MockPedia{
            id         : 0x2::object::new(arg4),
            name       : v1,
            url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&v2)),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v3, v4),
        };
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockPedia>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockPedia, Witness>(v6), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MockPedia>(arg2), &v5);
        *v0 = *v0 + 1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<MockPedia>(arg1, v5, arg4);
    }

    public entry fun split_and_transfer_mint_cap(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockPedia>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockPedia>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<MockPedia>(arg0, arg1, arg3), arg2);
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

