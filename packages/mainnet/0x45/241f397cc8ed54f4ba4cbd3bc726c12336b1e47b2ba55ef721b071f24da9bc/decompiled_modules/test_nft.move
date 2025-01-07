module 0x45241f397cc8ed54f4ba4cbd3bc726c12336b1e47b2ba55ef721b071f24da9bc::test_nft {
    struct TEST_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<TEST_NFT, TestNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<TEST_NFT>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<TestNFT, Witness>(v5);
        let v7 = 0x2::display::new<TestNFT>(&v4, arg1);
        0x2::display::add<TestNFT>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TestNFT>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<TestNFT>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x2::display::add<TestNFT>(&mut v7, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v8));
        0x2::display::update_version<TestNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<TestNFT>>(v7, 0x2::tx_context::sender(arg1));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<TestNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Catty 5"), 0x1::string::utf8(b"pet the cat by selling the NFT")));
        let v9 = vector[@0x2eb44d6fe52d6b336f1e4cc039da467b6d5cccb05084c6e5f5d8b9cce21c4b9f];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<TestNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v9)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<TestNFT>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v9, vector[10000]), arg1), 5, arg1);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<TestNFT>(&v4, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<TestNFT>(&mut v13, &v12);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TestNFT>>(v12, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<TestNFT>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<TestNFT>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TestNFT>>(v13);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<TestNFT>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TestNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<TestNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<TestNFT, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<TestNFT>(arg3), &v0);
        0x2::transfer::public_transfer<TestNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

