module 0xfe838b3acf8f4703ae266c467106c09054e786475d719dc2159e966eb2652aa3::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"SUI GOD", x"5468652063756c7475726520746f6b656e206f66205375692e20205061726f6479206d656d652070726f6a6563742e204e6f7420616666696c69617465642077697468207265616c206c6966652070656f706c65206f7220636f6d70616e6965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_ZD_Ug_XJ_400x400_8b41f7cb8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

