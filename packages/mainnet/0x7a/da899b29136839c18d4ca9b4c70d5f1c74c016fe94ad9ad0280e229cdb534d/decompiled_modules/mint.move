module 0x7ada899b29136839c18d4ca9b4c70d5f1c74c016fe94ad9ad0280e229cdb534d::mint {
    struct SuiEcosystemNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        lvl: u8,
    }

    struct SuiEcosystemHub has store, key {
        id: 0x2::object::UID,
        minted: u64,
        images: 0x2::vec_map::VecMap<u8, 0x2::url::Url>,
        collection_id: 0x2::object::ID,
    }

    struct MINT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct NftMinted has copy, drop {
        id: 0x2::object::ID,
        minter: address,
    }

    struct NftUpgraded has copy, drop {
        id: 0x2::object::ID,
    }

    public entry fun mint(arg0: &mut SuiEcosystemHub, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<SuiEcosystemNFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minted + 1;
        assert!(v0 <= 1777, 0);
        arg0.minted = v0;
        let v1 = 0x1::string::utf8(b"Sui Ecosystem");
        0x1::string::append_utf8(&mut v1, b" #");
        0x1::string::append(&mut v1, to_string(v0));
        let v2 = 1;
        let v3 = SuiEcosystemNFT{
            id          : 0x2::object::new(arg2),
            name        : v1,
            description : 0x1::string::utf8(b"Sui Ecosystem is your best opportunity to explore all the projects on the @SuiNetwork blockchain!"),
            url         : *0x2::vec_map::get<u8, 0x2::url::Url>(&arg0.images, &v2),
            lvl         : 1,
        };
        let v4 = NftMinted{
            id     : 0x2::object::uid_to_inner(&v3.id),
            minter : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NftMinted>(v4);
        let v5 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SuiEcosystemNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuiEcosystemNFT, Witness>(v5), arg0.collection_id, &v3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<SuiEcosystemNFT>(arg1, v3);
    }

    fun check_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<MINT>(arg0), 2);
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_from_otw<MINT, SuiEcosystemNFT>(&arg0, arg1);
        let v1 = 0x2::package::claim<MINT>(arg0, arg1);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuiEcosystemNFT, Witness>(v2);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"ipfs://{url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://twitter.com/SuiEcosystem"));
        let v8 = 0x2::display::new_with_fields<SuiEcosystemNFT>(&v1, v4, v6, arg1);
        0x2::display::update_version<SuiEcosystemNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<SuiEcosystemNFT>>(v8, 0x2::tx_context::sender(arg1));
        let v9 = 0x2::vec_map::empty<u8, 0x2::url::Url>();
        0x2::vec_map::insert<u8, 0x2::url::Url>(&mut v9, 1, 0x2::url::new_unsafe_from_bytes(b"QmRCGP8tF1YkEeBFXW7Ck3h4Z1UWpiBFUYjNn9ox3ASPPK"));
        0x2::vec_map::insert<u8, 0x2::url::Url>(&mut v9, 2, 0x2::url::new_unsafe_from_bytes(b"QmUMhRPKZ49Vtgyn9Q7BG2hpiqJNmgWNhtbsJWvusFd5Jj"));
        0x2::vec_map::insert<u8, 0x2::url::Url>(&mut v9, 3, 0x2::url::new_unsafe_from_bytes(b"QmX6AMrzL8tieGXDCp2eXGTyw8d2fyFCC4PXJpFnV3Lx9S"));
        assert!(0x2::vec_map::size<u8, 0x2::url::Url>(&v9) == (3 as u64), 1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuiEcosystemNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v3, &mut v0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Sui Ecosystem"), 0x1::string::utf8(b"Sui Ecosystem is your best opportunity to explore all the projects on the @SuiNetwork blockchain!")));
        let v10 = vector[@0xc02cee8120e1f9b4df562a2f3033ab2dd45489746330863477e8e264a0b4a7d6];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuiEcosystemNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v3, &mut v0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<SuiEcosystemNFT>(v3, &mut v0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(vector[@0xc02cee8120e1f9b4df562a2f3033ab2dd45489746330863477e8e264a0b4a7d6, @0x61028a4c388514000a7de787c3f7b8ec1eb88d1bd2dbc0d3dfab37078e39630f], vector[9500, 500]), arg1), 1000, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<SuiEcosystemNFT>(&v1, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<SuiEcosystemNFT>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<SuiEcosystemNFT>(&mut v14, &v13);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_unprotected<SuiEcosystemNFT, 0x2::sui::SUI>(v3, &v14, arg1);
        let (v15, v16) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v17 = v16;
        let v18 = v15;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Witness>(&v17, &mut v18);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding::Witness>(&v17, &mut v18);
        let v19 = SuiEcosystemHub{
            id            : 0x2::object::new(arg1),
            minted        : 0,
            images        : v9,
            collection_id : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SuiEcosystemNFT>>(&v0),
        };
        0x2::transfer::share_object<SuiEcosystemHub>(v19);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v17, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiEcosystemNFT>>(v13, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v18);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SuiEcosystemNFT>>(v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiEcosystemNFT>>(v14);
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun upgrade_nft(arg0: &mut SuiEcosystemHub, arg1: &mut SuiEcosystemNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.lvl + 1;
        assert!(v0 <= 3, 1);
        let v1 = NftUpgraded{id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::event::emit<NftUpgraded>(v1);
        arg1.lvl = v0;
        arg1.url = *0x2::vec_map::get<u8, 0x2::url::Url>(&arg0.images, &v0);
    }

    // decompiled from Move bytecode v6
}

