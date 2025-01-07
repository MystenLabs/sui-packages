module 0x884ea726274d59e314d21bfad3fb636746d7ccffdfea87e5baf04e323e1adb94::nft {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ABEX_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let (v2, v3) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<NFT, ABEX_NFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v4 = v2;
        let v5 = 0x2::package::claim<NFT>(arg0, arg1);
        let v6 = 0x2::display::new<ABEX_NFT>(&v5, arg1);
        0x2::display::add<ABEX_NFT>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<ABEX_NFT>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<ABEX_NFT>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<ABEX_NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<ABEX_NFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<ABEX_NFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<ABEX_NFT, Witness>(v7), &mut v4, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"ABEx-OKX Badges"), 0x1::string::utf8(b"This is a special reward for participating in the OKX wallet event.")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<ABEX_NFT>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<ABEX_NFT>>(v4);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &AdminCap, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<ABEX_NFT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = ABEX_NFT{
                id          : 0x2::object::new(arg3),
                name        : 0x1::string::utf8(b"ABEx-OKX Badges"),
                description : 0x1::string::utf8(b"This is a special reward for participating in the OKX wallet event."),
                url         : 0x2::url::new_unsafe_from_bytes(b"https://cloudflare-ipfs.com/ipfs/QmZ54N5bRKxvQMwwGAjWukGAsXbta9GeLsgifMYKcDGtaG"),
            };
            0x2::transfer::public_transfer<ABEX_NFT>(v1, *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

