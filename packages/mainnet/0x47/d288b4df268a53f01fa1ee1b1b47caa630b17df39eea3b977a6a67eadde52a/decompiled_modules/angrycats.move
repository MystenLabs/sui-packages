module 0x47d288b4df268a53f01fa1ee1b1b47caa630b17df39eea3b977a6a67eadde52a::angrycats {
    struct ANGRYCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYCATS>(arg0, 6, b"Angrycats", b"angry cat's", x"4e4f2068756d6f7220666f7220464f4d4f20616e796d6f72652c57687920616e204361742773206973206f6e206869732077617920746f206d757264657220657665727920726574617264656420696e7465726e6574206d656d6520636f696e2e204f6e65206d656d6520617420612074696d6520756e74696c206865206265636f6d657320746865204c415354204f4e452e0a0a4d6565656f6f6f7777777720212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/photo_2024_09_20_15_20_33_1277e7697b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

