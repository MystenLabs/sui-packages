module 0x6c6cb77bde440f34876eb7b529109f5e2551a9f3520e3201083fbf8e6bf41a96::facial_hair {
    struct FACIAL_HAIR has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct FacialHair has store, key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
    }

    fun init(arg0: FACIAL_HAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<FACIAL_HAIR, FacialHair>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = 0x2::package::claim<FACIAL_HAIR>(arg0, arg1);
        let v4 = 0x2::display::new<FacialHair>(&v3, arg1);
        0x2::display::add<FacialHair>(&mut v4, 0x1::string::utf8(b"value"), 0x1::string::utf8(b"{value}"));
        0x2::display::update_version<FacialHair>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<FacialHair>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<FacialHair>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<FacialHair>>(v1);
    }

    public(friend) fun mint_(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : FacialHair {
        FacialHair{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

