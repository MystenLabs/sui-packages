module 0x9847162062863159614d8faa1aafd1e99b46372a2773b9487e9bcf8d96306dd4::soulbound {
    struct SOULBOUND has drop {
        dummy_field: bool,
    }

    struct MissionControlSoulbound has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        link: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOULBOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<SOULBOUND, MissionControlSoulbound>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<SOULBOUND>(arg0, arg1);
        let v5 = 0x2::display::new<MissionControlSoulbound>(&v4, arg1);
        0x2::display::add<MissionControlSoulbound>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MissionControlSoulbound>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MissionControlSoulbound>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://{url}"));
        0x2::display::add<MissionControlSoulbound>(&mut v5, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://{link}"));
        0x2::display::update_version<MissionControlSoulbound>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MissionControlSoulbound>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<MissionControlSoulbound, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MissionControlSoulbound, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Mission Control Soulbound"), 0x1::string::utf8(b"Project Eluune mission control soulbound collection")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MissionControlSoulbound>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<MissionControlSoulbound>>(v3);
    }

    public entry fun mint_soulbound_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MissionControlSoulbound>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = &mut arg2;
        0x1::string::append(v1, 0x1::string::utf8(b"0x"));
        0x1::string::append(v1, 0x2::address::to_string(0x2::object::uid_to_address(&v0)));
        0x1::string::append(v1, 0x1::string::utf8(b"/image"));
        let v2 = MissionControlSoulbound{
            id          : v0,
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(*v1)),
            link        : 0x2::url::new_unsafe(0x1::string::to_ascii(*v1)),
        };
        0x2::transfer::transfer<MissionControlSoulbound>(v2, arg4);
    }

    // decompiled from Move bytecode v6
}

