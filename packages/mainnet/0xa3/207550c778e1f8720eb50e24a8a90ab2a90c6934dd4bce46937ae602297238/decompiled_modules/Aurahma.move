module 0xa3207550c778e1f8720eb50e24a8a90ab2a90c6934dd4bce46937ae602297238::Aurahma {
    struct AURAHMA has drop {
        dummy_field: bool,
    }

    struct AurahmaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<AURAHMA, AurahmaNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<AURAHMA>(arg0, arg1);
        let v5 = 0x2::display::new<AurahmaNFT>(&v4, arg1);
        0x2::display::add<AurahmaNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AurahmaNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AurahmaNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<AurahmaNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<AurahmaNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<AurahmaNFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AurahmaNFT, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Aurahma"), 0x1::string::utf8(b"Aurahma NFT collection")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<AurahmaNFT>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AurahmaNFT>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2;
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        0x1::vector::append<u8>(v0, 0x2::object::id_to_bytes(&v2));
        let v3 = AurahmaNFT{
            id          : v1,
            name        : arg0,
            description : arg1,
            link        : 0x2::url::new_unsafe_from_bytes(*v0),
        };
        0x2::transfer::public_transfer<AurahmaNFT>(v3, arg4);
    }

    // decompiled from Move bytecode v6
}

