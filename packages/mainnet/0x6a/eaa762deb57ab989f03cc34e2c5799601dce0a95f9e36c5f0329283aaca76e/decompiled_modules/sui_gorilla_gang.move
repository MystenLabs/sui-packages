module 0x6aeaa762deb57ab989f03cc34e2c5799601dce0a95f9e36c5f0329283aaca76e::sui_gorilla_gang {
    struct SUI_GORILLA_GANG has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SuiGorillaGang has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    fun init(arg0: SUI_GORILLA_GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<SUI_GORILLA_GANG, SuiGorillaGang>(&arg0, 0x1::option::some<u64>(100), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<SUI_GORILLA_GANG>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        let v6 = 0x2::display::new<SuiGorillaGang>(&v4, arg1);
        0x2::display::add<SuiGorillaGang>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiGorillaGang>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiGorillaGang>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::add<SuiGorillaGang>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<SuiGorillaGang>(&mut v6, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<SuiGorillaGang>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<SuiGorillaGang>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Witness{dummy_field: false};
        let v8 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuiGorillaGang, Witness>(v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuiGorillaGang, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Sui Gorilla Gang"), 0x1::string::utf8(b"A gang of Sui homies who don't abandon their roots.")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SuiGorillaGang, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x2::vec_set::singleton<address>(v0)));
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<SuiGorillaGang>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v9, vector[10000]), arg1), 199, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SuiGorillaGang>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SuiGorillaGang>>(v3);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SuiGorillaGang>, arg6: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::warehouse::Warehouse<SuiGorillaGang>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiGorillaGang{
            id          : 0x2::object::new(arg8),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg3, arg4),
        };
        let v1 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SuiGorillaGang>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SuiGorillaGang, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<SuiGorillaGang>(arg5), &v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<SuiGorillaGang>(arg5, 1);
        if (arg7) {
            0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::warehouse::deposit_nft<SuiGorillaGang>(arg6, v0);
        } else {
            0x2::transfer::public_transfer<SuiGorillaGang>(v0, 0x2::tx_context::sender(arg8));
        };
    }

    // decompiled from Move bytecode v6
}

