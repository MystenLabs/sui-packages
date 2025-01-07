module 0x2b76d70ac05afb7ee9afe05e99d2c742a49d698bcb2fd42cac4ad639d51009a0::divine_art {
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
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_image_url"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://clutchy.app"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Divine Art"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://clutchy.app"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://clutchy.io/static/media/mascot.4c202c3b7aca241ebbf64fff0b350b2f.svg"));
        let v9 = 0x2::display::new_with_fields<DivineArtNft>(&v4, v5, v7, arg1);
        0x2::display::update_version<DivineArtNft>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<DivineArtNft>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<DivineArtNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<DivineArtNft, Witness>(v10), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Divine Art OG"), 0x1::string::utf8(b"Dvine Art OG collection on Sui")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<DivineArtNft>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<DivineArtNft>>(v3);
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

