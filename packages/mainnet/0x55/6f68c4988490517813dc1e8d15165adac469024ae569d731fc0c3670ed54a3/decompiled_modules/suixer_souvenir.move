module 0x556f68c4988490517813dc1e8d15165adac469024ae569d731fc0c3670ed54a3::suixer_souvenir {
    struct SUIXER_SOUVENIR has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SuixerSouvenir has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    fun init(arg0: SUIXER_SOUVENIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<SUIXER_SOUVENIR, SuixerSouvenir>(&arg0, 0x1::option::some<u64>(999), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<SUIXER_SOUVENIR>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        let v6 = 0x2::display::new<SuixerSouvenir>(&v4, arg1);
        0x2::display::add<SuixerSouvenir>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuixerSouvenir>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuixerSouvenir>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::add<SuixerSouvenir>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<SuixerSouvenir>(&mut v6, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<SuixerSouvenir>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<SuixerSouvenir>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Witness{dummy_field: false};
        let v8 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuixerSouvenir, Witness>(v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuixerSouvenir, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Souvenir"), 0x1::string::utf8(b"Suixer mainnet souvenirs designed to test the platform.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuixerSouvenir, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x2::vec_set::singleton<address>(v0)));
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<SuixerSouvenir>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v9, vector[10000]), arg1), 199, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SuixerSouvenir>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SuixerSouvenir>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SuixerSouvenir>, arg6: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::warehouse::Warehouse<SuixerSouvenir>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = SuixerSouvenir{
            id          : 0x2::object::new(arg8),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SuixerSouvenir>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuixerSouvenir, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<SuixerSouvenir>(arg5), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<SuixerSouvenir>(arg5, 1);
        if (arg7) {
            0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::warehouse::deposit_nft<SuixerSouvenir>(arg6, v0);
        } else {
            0x2::transfer::public_transfer<SuixerSouvenir>(v0, 0x2::tx_context::sender(arg8));
        };
    }

    // decompiled from Move bytecode v6
}

