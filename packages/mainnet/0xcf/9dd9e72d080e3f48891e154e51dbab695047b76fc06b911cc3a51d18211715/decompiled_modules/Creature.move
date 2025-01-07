module 0xcf9dd9e72d080e3f48891e154e51dbab695047b76fc06b911cc3a51d18211715::Creature {
    struct CREATURE has drop {
        dummy_field: bool,
    }

    struct CreatureNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x2::url::Url,
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATURE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<CREATURE, CreatureNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<CREATURE>(arg0, arg1);
        let v5 = 0x2::display::new<CreatureNFT>(&v4, arg1);
        0x2::display::add<CreatureNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<CreatureNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<CreatureNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<CreatureNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<CreatureNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<CreatureNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<CreatureNFT, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Creature"), 0x1::string::utf8(b"Creature NFT collection")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CreatureNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<CreatureNFT>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CreatureNFT>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = &mut arg2;
        0x1::string::append(v1, 0x1::string::utf8(b"0x"));
        0x1::string::append(v1, 0x2::address::to_string(0x2::object::uid_to_address(&v0)));
        0x1::string::append(v1, 0x1::string::utf8(b".json"));
        let v2 = CreatureNFT{
            id          : v0,
            name        : arg0,
            description : arg1,
            link        : 0x2::url::new_unsafe(0x1::string::to_ascii(*v1)),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://www.projecteluune.com/"),
        };
        0x2::transfer::public_transfer<CreatureNFT>(v2, arg4);
    }

    // decompiled from Move bytecode v6
}

