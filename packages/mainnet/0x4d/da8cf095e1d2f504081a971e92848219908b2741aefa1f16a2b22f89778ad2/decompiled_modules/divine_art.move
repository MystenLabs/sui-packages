module 0x4dda8cf095e1d2f504081a971e92848219908b2741aefa1f16a2b22f89778ad2::divine_art {
    struct DIVINE_ART has drop {
        dummy_field: bool,
    }

    struct DivineArtNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        data: 0x1::string::String,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINE_ART, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<DIVINE_ART, DivineArtNft>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<DIVINE_ART>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::profile_picture());
        let v6 = 0x2::display::new<DivineArtNft>(&v4, arg1);
        0x2::display::add<DivineArtNft>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DivineArtNft>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DivineArtNft>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<DivineArtNft>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<DivineArtNft>(&mut v6, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<DivineArtNft>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<DivineArtNft>>(v6, v0);
        let v7 = Witness{dummy_field: false};
        let v8 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<DivineArtNft, Witness>(v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<DivineArtNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Divine Art devs are testing again..."), 0x1::string::utf8(b"This is just another integration test")));
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, @0x677741f14da930cc6bfde74ebe1df443ca030fe80666e72e2f1b71b94a9fa002);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<DivineArtNft>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v9, vector[10000]), arg1), 500, arg1);
        let (v10, v11) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<DivineArtNft>(&v4, arg1);
        let v12 = v11;
        let v13 = v10;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<DivineArtNft>(&mut v13, &v12);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<DivineArtNft>(&mut v13, &v12);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<DivineArtNft, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<DivineArtNft, 0x2::sui::SUI>(v8, &v13, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg1));
        let (v14, v15) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v16 = v15;
        let v17 = v14;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Witness>(&v16, &mut v17);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Witness>(&v16, &mut v17);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<DivineArtNft>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v16, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DivineArtNft>>(v12, v0);
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v17);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<DivineArtNft>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DivineArtNft>>(v13);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : DivineArtNft {
        DivineArtNft{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            image_url   : arg1,
            description : arg2,
            data        : arg3,
        }
    }

    public fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<DivineArtNft>, arg5: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<DivineArtNft>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg6);
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<DivineArtNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<DivineArtNft, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<DivineArtNft>(arg4), &v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<DivineArtNft>(arg5, v0);
    }

    public entry fun pub_mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DivineArtNft{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            image_url   : arg1,
            description : arg2,
            data        : arg3,
        };
        0x2::transfer::transfer<DivineArtNft>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

