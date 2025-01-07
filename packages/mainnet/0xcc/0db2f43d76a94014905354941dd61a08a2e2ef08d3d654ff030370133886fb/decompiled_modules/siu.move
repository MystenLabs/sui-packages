module 0xcc0db2f43d76a94014905354941dd61a08a2e2ef08d3d654ff030370133886fb::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIUUUU", x"6d79206e616d6520697320437269737469616e6f20616e642049206c6f766520535549200a4c657473206d616b65207468697320746865206e756d626572206f6e65206d656d65636f696e206f6e20535549494949490a53495555555520212121212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ona_b64be503e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

