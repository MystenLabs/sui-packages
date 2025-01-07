module 0x71bd3651e47a7590e607b976a332338e2230e995fa96de430703af537086b643::cryptopedia {
    struct CRYPTOPEDIA has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Cryptopedia has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct CryptopediaMetadata has store, key {
        id: 0x2::object::UID,
        name: vector<0x1::string::String>,
        url: vector<0x1::string::String>,
        mint_count: vector<u64>,
        attribute_key: 0x1::ascii::String,
        attribute_value: vector<0x1::ascii::String>,
    }

    public entry fun disable_orderbook<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Cryptopedia, T0>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::disable_orderbook<Cryptopedia, T0>(arg0, arg1);
    }

    public entry fun enable_orderbook<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Cryptopedia, T0>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::enable_orderbook<Cryptopedia, T0>(arg0, arg1);
    }

    public entry fun delete_mint_cap(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::delete_mint_cap<Cryptopedia>(arg0);
    }

    fun init(arg0: CRYPTOPEDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<CRYPTOPEDIA, Cryptopedia>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<CRYPTOPEDIA>(arg0, arg1);
        let v5 = 0x2::display::new<Cryptopedia>(&v4, arg1);
        0x2::display::add<Cryptopedia>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Cryptopedia>(&mut v5, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<Cryptopedia>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Cryptopedia>>(v5, v0);
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Cryptopedia, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Cryptopedia, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"SUI&OKX Cryptopedia NFT"), 0x1::string::utf8(b"SUI&OKX Cryptopedia NFT is the proof and reward for participating in SUI&OKX Cryptopedia.")));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Poseiden"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Neptune"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Triton"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Aegir"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Njord"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmY5jCRWZH3Vte2dgxGbQXTf7EnQEba6X4hQmjG3Sc38xd"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmTMSojTtwWvZSiw1a5b4QmyvsenzvYVS7ee9GET4tjLVG"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmbDgo6jKawqiJ6AKCtuCoxM2Qkt3tyv6Q5zGKWJ2M9Czr"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmWJ2gkustivVPhaJaoi7xgwgvSjnvtdJK6e4kXjka5SiX"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmV8TZSCKFKzg6rCZq99VWPBtxM4iXecCqLJtHeLaNnDUw"));
        let v11 = 0x1::vector::empty<0x1::ascii::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"R"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"SSR"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"SSR"));
        let v13 = CryptopediaMetadata{
            id              : 0x2::object::new(arg1),
            name            : v7,
            url             : v9,
            mint_count      : vector[0, 0, 0, 0, 0],
            attribute_key   : 0x1::ascii::string(b"Rarity"),
            attribute_value : v11,
        };
        let (v14, v15) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Cryptopedia>(&v4, arg1);
        let v16 = v15;
        let v17 = v14;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Cryptopedia>(&mut v17, &v16);
        let (v18, v19) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Cryptopedia>(&v4, arg1);
        let v20 = v19;
        let v21 = v18;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Cryptopedia>(&mut v21, &v20);
        let (v22, v23) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg1);
        let v24 = v23;
        let v25 = v22;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Witness>(&v24, &mut v25);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_collection<Cryptopedia>(&mut v25, &v4);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Cryptopedia>>(v16, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Cryptopedia>>(v20, v0);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v24, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Cryptopedia>>(v3);
        0x2::transfer::public_share_object<CryptopediaMetadata>(v13);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Cryptopedia>>(v17);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Cryptopedia>>(v21);
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v25);
    }

    fun mint_nft_(arg0: u64, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>, arg2: &mut CryptopediaMetadata, arg3: &mut 0x2::tx_context::TxContext) : Cryptopedia {
        assert!(arg0 >= 1 && arg0 <= 5, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg2.mint_count, arg0 - 1);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg2.name, arg0 - 1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, u64ToString(*v0));
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, arg2.attribute_key);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, *0x1::vector::borrow<0x1::ascii::String>(&arg2.attribute_value, arg0 - 1));
        let v4 = Cryptopedia{
            id         : 0x2::object::new(arg3),
            name       : v1,
            url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(0x1::vector::borrow<0x1::string::String>(&arg2.url, arg0 - 1))),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v2, v3),
        };
        let v5 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Cryptopedia>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Cryptopedia, Witness>(v5), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Cryptopedia>(arg1), &v4);
        *v0 = *v0 + 1;
        v4
    }

    public entry fun mint_nft_to_address(arg0: u64, arg1: address, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>, arg3: &mut CryptopediaMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Cryptopedia>(mint_nft_(arg0, arg2, arg3, arg4), arg1);
    }

    public entry fun mint_nft_to_kiosk(arg0: u64, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>, arg3: &mut CryptopediaMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_nft_(arg0, arg2, arg3, arg4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Cryptopedia>(arg1, v0, arg4);
    }

    public entry fun split_and_transfer_mint_cap(arg0: &0x2::package::Publisher, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Cryptopedia>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<Cryptopedia>(arg1, arg2, arg4), arg3);
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

