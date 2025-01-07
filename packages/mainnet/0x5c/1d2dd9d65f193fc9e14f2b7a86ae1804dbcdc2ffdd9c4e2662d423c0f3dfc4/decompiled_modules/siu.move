module 0x5c1d2dd9d65f193fc9e14f2b7a86ae1804dbcdc2ffdd9c4e2662d423c0f3dfc4::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIUU", x"24534955552069732061206d656d65746f6b656e206f6e20535549206e6574776f726b2c206275696c7420627920436f6d6d756e69747920666f722074686520436f6d6d756e697479200a0a52454e414c444f2049532054484520474f415421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SIUU_Icon_White_Background_01_a872e17de1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

