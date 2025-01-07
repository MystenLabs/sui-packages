module 0x41a2f6e3844a40661117394bae27058b69fbfc7c92ec2542834db158dcae5494::FoundingStargarden {
    struct FOUNDINGSTARGARDEN has drop {
        dummy_field: bool,
    }

    struct FoundingStargardenNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x2::url::Url,
        image_url: 0x2::url::Url,
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOUNDINGSTARGARDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<FOUNDINGSTARGARDEN, FoundingStargardenNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<FOUNDINGSTARGARDEN>(arg0, arg1);
        let v5 = 0x2::display::new<FoundingStargardenNFT>(&v4, arg1);
        0x2::display::add<FoundingStargardenNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<FoundingStargardenNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<FoundingStargardenNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<FoundingStargardenNFT>(&mut v5, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{link}"));
        0x2::display::add<FoundingStargardenNFT>(&mut v5, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<FoundingStargardenNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<FoundingStargardenNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<FoundingStargardenNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<FoundingStargardenNFT, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"FoundingStargarden"), 0x1::string::utf8(b"FoundingStargarden NFT collection")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<FoundingStargardenNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<FoundingStargardenNFT>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<FoundingStargardenNFT>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = FoundingStargardenNFT{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            link        : 0x2::url::new_unsafe_from_bytes(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://www.projecteluune.com/"),
        };
        0x2::transfer::public_transfer<FoundingStargardenNFT>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

