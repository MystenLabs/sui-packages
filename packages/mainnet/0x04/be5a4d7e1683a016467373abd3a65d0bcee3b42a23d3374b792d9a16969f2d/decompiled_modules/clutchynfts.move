module 0x4be5a4d7e1683a016467373abd3a65d0bcee3b42a23d3374b792d9a16969f2d::clutchynfts {
    struct CLUTCHYNFTS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct ClutchyNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    fun init(arg0: CLUTCHYNFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<CLUTCHYNFTS, ClutchyNft>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<CLUTCHYNFTS>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        let v7 = 0x2::display::new<ClutchyNft>(&v4, arg1);
        0x2::display::add<ClutchyNft>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<ClutchyNft>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<ClutchyNft>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<ClutchyNft>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<ClutchyNft>(&mut v7, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<ClutchyNft>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<ClutchyNft>>(v7, 0x2::tx_context::sender(arg1));
        let v8 = Witness{dummy_field: false};
        let v9 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<ClutchyNft, Witness>(v8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<ClutchyNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Suimarines"), 0x1::string::utf8(b"A unique NFT collection of Suimarines on Sui")));
        let v10 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v10, v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<ClutchyNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<ClutchyNft>(v9, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v10, vector[10000]), arg1), 5000, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<ClutchyNft>(&v4, arg1);
        let v13 = v12;
        let v14 = v11;
        let v15 = Witness{dummy_field: false};
        0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::create_unprotected<ClutchyNft, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<ClutchyNft, Witness>(v15), &v14, arg1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<ClutchyNft>(&mut v14, &v13);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<ClutchyNft>>(v2, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ClutchyNft>>(v13, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ClutchyNft>>(v14);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<ClutchyNft>>(v3);
        let (v16, v17) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v18 = v17;
        let v19 = v16;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Witness>(&v18, &mut v19);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::bidding::Witness>(&v18, &mut v19);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v18, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v19);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<ClutchyNft>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<ClutchyNft>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = ClutchyNft{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<ClutchyNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<ClutchyNft, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<ClutchyNft>(arg5), &v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<ClutchyNft>(arg6, v0);
    }

    // decompiled from Move bytecode v6
}

