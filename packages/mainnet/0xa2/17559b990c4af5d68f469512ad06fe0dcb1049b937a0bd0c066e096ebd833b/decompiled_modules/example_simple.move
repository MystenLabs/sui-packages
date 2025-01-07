module 0xa217559b990c4af5d68f469512ad06fe0dcb1049b937a0bd0c066e096ebd833b::example_simple {
    struct EXAMPLE_SIMPLE has drop {
        dummy_field: bool,
    }

    struct SimpleNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXAMPLE_SIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<EXAMPLE_SIMPLE, SimpleNft>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<EXAMPLE_SIMPLE>(arg0, arg1);
        let v5 = 0x2::display::new<SimpleNft>(&v4, arg1);
        0x2::display::add<SimpleNft>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SimpleNft>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SimpleNft>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://{url}"));
        0x2::display::update_version<SimpleNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<SimpleNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SimpleNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SimpleNft, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Simple"), 0x1::string::utf8(b"Simple collection on Sui")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SimpleNft>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SimpleNft>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SimpleNft>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleNft{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<SimpleNft>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

