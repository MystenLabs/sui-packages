module 0x69a382c3d8ab542b8b11b04be6ab1da2363aa55aff582cc19d03e8e9baea38b6::mocknft {
    struct MOCKNFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MockNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    public entry fun airdrop_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: address, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MockNft{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockNft, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MockNft>(arg6), &v0);
        0x2::transfer::public_transfer<MockNft>(v0, arg5);
    }

    public entry fun delete_mint_cap(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::delete_mint_cap<MockNft>(arg0);
    }

    fun init(arg0: MOCKNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<MOCKNFT, MockNft>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<MOCKNFT>(arg0, arg1);
        let v5 = 0x2::display::new<MockNft>(&v4, arg1);
        0x2::display::add<MockNft>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MockNft>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MockNft>(&mut v5, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<MockNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MockNft>>(v5, v0);
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockNft, Witness>(v6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<MockNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"MockNFT"), 0x1::string::utf8(b"Mock NFT collection on Sui")));
        let v8 = vector[@0x29dbaef556d2abdb865652ba4e4a7e850c730d7b493e81c61c355ee218185484, @0x8ce11575d910ddd8bf5d8bec616623de58dcc7249f812ecc47551b9593a32682, @0x2bd630ec80c511e934700d71b4bddd245e3fc718859807ef1c85a7c9691347cb, @0x5465d495fb5a88174d0ecd7c757b1bb1957c801f92fc67d3031cee40d3b3aff5, @0x4ac61320a37c4861afd68030f576ae767b84d7626d5642eed9228fe6053b053d];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<MockNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v8)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<MockNft>(v7, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v8, vector[2000, 2000, 2000, 2000, 2000]), arg1), 100, arg1);
        let (v9, v10) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<MockNft>(&v4, arg1);
        let v11 = v10;
        let v12 = v9;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<MockNft>(&mut v12, &v11);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<MockNft>(&mut v12, &v11);
        let (v13, v14) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<MockNft>(&v4, arg1);
        let v15 = v14;
        let v16 = v13;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<MockNft>(&mut v16, &v15);
        let v17 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::new(0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1);
        let v18 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::create_warehouse<MockNft>(&mut v17, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::fixed_price::init_venue<MockNft, 0x2::sui::SUI>(&mut v17, v18, false, 500, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::dutch_auction::init_venue<MockNft, 0x2::sui::SUI>(&mut v17, v18, false, 100, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MockNft>>(v11, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MockNft>>(v15, v0);
        0x2::transfer::public_share_object<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing>(v17);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<MockNft>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MockNft>>(v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MockNft>>(v16);
    }

    public entry fun mint_and_deposit(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<MockNft>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MockNft{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockNft, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MockNft>(arg5), &v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<MockNft>(arg6, v0);
    }

    public entry fun public_mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = MockNft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MockNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MockNft, Witness>(v1), arg5, &v0);
        0x2::transfer::public_transfer<MockNft>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun split_and_transfer_mint_cap(arg0: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<MockNft>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer_mint_cap(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>, arg1: address) {
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MockNft>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

