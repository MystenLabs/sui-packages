module 0x5d8c22d0ee3bee3677f979511b70b1c493d71e370baa5e6b6c098908ea02800b::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Eyes has store, key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<EYES, Eyes>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = 0x2::package::claim<EYES>(arg0, arg1);
        let v4 = 0x2::display::new<Eyes>(&v3, arg1);
        0x2::display::add<Eyes>(&mut v4, 0x1::string::utf8(b"value"), 0x1::string::utf8(b"{value}"));
        0x2::display::update_version<Eyes>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Eyes>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Eyes>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Eyes>>(v1);
    }

    public(friend) fun mint_(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Eyes {
        Eyes{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

