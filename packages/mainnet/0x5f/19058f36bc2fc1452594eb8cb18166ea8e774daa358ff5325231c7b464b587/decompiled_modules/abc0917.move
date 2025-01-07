module 0x5f19058f36bc2fc1452594eb8cb18166ea8e774daa358ff5325231c7b464b587::abc0917 {
    struct ABC0917 has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Abc0917 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct MetadataStore has store, key {
        id: 0x2::object::UID,
        name: vector<0x1::string::String>,
        description: vector<0x1::string::String>,
        url: vector<0x2::url::Url>,
        attributes: vector<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes>,
    }

    public entry fun create_metadata_store(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Abc0917>(arg0), 1);
        let v0 = MetadataStore{
            id          : 0x2::object::new(arg1),
            name        : 0x1::vector::empty<0x1::string::String>(),
            description : 0x1::vector::empty<0x1::string::String>(),
            url         : 0x1::vector::empty<0x2::url::Url>(),
            attributes  : 0x1::vector::empty<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes>(),
        };
        0x2::transfer::share_object<MetadataStore>(v0);
    }

    fun init(arg0: ABC0917, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<ABC0917, Abc0917>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<ABC0917>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Abc0917, Witness>(v5);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        let v8 = 0x2::display::new<Abc0917>(&v4, arg1);
        0x2::display::add<Abc0917>(&mut v8, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Abc0917>(&mut v8, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Abc0917>(&mut v8, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Abc0917>(&mut v8, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Abc0917>(&mut v8, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v7));
        0x2::display::update_version<Abc0917>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<Abc0917>>(v8, 0x2::tx_context::sender(arg1));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Abc0917, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"abc0917"), 0x1::string::utf8(b"I am the testing collection This is line 2")));
        let v9 = vector[@0x468a7fec4d3ef80a274c66e7f75981cac1423f463fcbe4644f97ad87702ceb5];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Abc0917, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v9)));
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<Abc0917>(&v4, arg1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Abc0917>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v9, vector[10000]), arg1), 0, arg1);
        let (v12, v13) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Abc0917>(&v4, arg1);
        let v14 = v13;
        let v15 = v12;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Abc0917>(&mut v15, &v14);
        let v16 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::new(0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::fixed_price::init_venue<Abc0917, 0x2::sui::SUI>(&mut v16, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::create_warehouse<Abc0917>(&mut v16, arg1), false, 100000000, arg1);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_unprotected<Abc0917, 0x2::sui::SUI>(v6, &v15, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Abc0917>>(v2, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Abc0917>>(v14, v0);
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v11, v0);
        0x2::transfer::public_share_object<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing>(v16);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Abc0917>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Abc0917>>(v15);
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<Abc0917, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v10);
    }

    public entry fun insert_nft_metadata(arg0: &0x2::package::Publisher, arg1: &mut MetadataStore, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Abc0917>(arg0), 1);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.name, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.description, arg3);
        0x1::vector::push_back<0x2::url::Url>(&mut arg1.url, 0x2::url::new_unsafe_from_bytes(arg4));
        0x1::vector::push_back<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes>(&mut arg1.attributes, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg5, arg6));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Abc0917>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Abc0917{
            id          : 0x2::object::new(arg8),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Abc0917>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Abc0917, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Abc0917>(arg5), &v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::deposit_nft<Abc0917>(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::inventory_admin_mut<Abc0917>(arg6, arg7, arg8), v0);
    }

    public entry fun mint_nft_to_wallet(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Abc0917>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Abc0917{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Abc0917>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Abc0917, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Abc0917>(arg5), &v0);
        0x2::transfer::public_transfer<Abc0917>(v0, arg6);
    }

    public entry fun reveal_nft(arg0: &mut Abc0917, arg1: &mut MetadataStore, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&mut arg1.id, 0x2::object::id<Abc0917>(arg0)), 1);
        let v0 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1.name);
        let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1.description);
        if (!0x1::string::is_empty(&v0)) {
            arg0.name = v0;
        };
        if (!0x1::string::is_empty(&v1)) {
            arg0.description = v1;
        };
        arg0.url = 0x1::vector::pop_back<0x2::url::Url>(&mut arg1.url);
        arg0.attributes = 0x1::vector::pop_back<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes>(&mut arg1.attributes);
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg1.id, 0x2::object::id<Abc0917>(arg0), true);
    }

    // decompiled from Move bytecode v6
}

