module 0x8b796485174eee31d2cd7a59d0f839b3e40044f98ab7d02331628d24bd4121cc::suixer_flipstar {
    struct SUIXER_FLIPSTAR has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SuixerFlipstar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    fun init(arg0: SUIXER_FLIPSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<SUIXER_FLIPSTAR, SuixerFlipstar>(&arg0, 0x1::option::some<u64>(999), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<SUIXER_FLIPSTAR>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        let v6 = 0x2::display::new<SuixerFlipstar>(&v4, arg1);
        0x2::display::add<SuixerFlipstar>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuixerFlipstar>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuixerFlipstar>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::add<SuixerFlipstar>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<SuixerFlipstar>(&mut v6, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<SuixerFlipstar>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<SuixerFlipstar>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Witness{dummy_field: false};
        let v8 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuixerFlipstar, Witness>(v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuixerFlipstar, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Flipstar"), 0x1::string::utf8(b"A limited collection of utility NFTs issued by Suixer. Holders of Flipstars will enjoy trading benefits like a 0.5% fee decrease & more.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuixerFlipstar, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x2::vec_set::singleton<address>(v0)));
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<SuixerFlipstar>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v9, vector[10000]), arg1), 199, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SuixerFlipstar>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SuixerFlipstar>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SuixerFlipstar>, arg6: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<SuixerFlipstar>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = SuixerFlipstar{
            id          : 0x2::object::new(arg8),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SuixerFlipstar>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuixerFlipstar, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<SuixerFlipstar>(arg5), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<SuixerFlipstar>(arg5, 1);
        if (arg7) {
            0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<SuixerFlipstar>(arg6, v0);
        } else {
            0x2::transfer::public_transfer<SuixerFlipstar>(v0, 0x2::tx_context::sender(arg8));
        };
    }

    // decompiled from Move bytecode v6
}

