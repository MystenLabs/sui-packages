module 0xdd5da9b6751f29597ca51aebf96aec4fb93f4263c4dadd9c8798455a89375796::arm_left {
    struct ARM_LEFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct ArmLeft has store, key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
    }

    fun init(arg0: ARM_LEFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<ARM_LEFT, ArmLeft>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = 0x2::package::claim<ARM_LEFT>(arg0, arg1);
        let v4 = 0x2::display::new<ArmLeft>(&v3, arg1);
        0x2::display::add<ArmLeft>(&mut v4, 0x1::string::utf8(b"value"), 0x1::string::utf8(b"{value}"));
        0x2::display::update_version<ArmLeft>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<ArmLeft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<ArmLeft>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<ArmLeft>>(v1);
    }

    public(friend) fun mint_(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : ArmLeft {
        ArmLeft{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

