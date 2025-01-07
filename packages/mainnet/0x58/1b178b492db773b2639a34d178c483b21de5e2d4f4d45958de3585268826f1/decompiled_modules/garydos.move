module 0x581b178b492db773b2639a34d178c483b21de5e2d4f4d45958de3585268826f1::garydos {
    struct GARYDOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARYDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARYDOS>(arg0, 6, b"GARYDOS", b"Garydos on Sui", x"4261736963616c6c792c204779617261646f73206675636b65642047617279207468652073656120736e61696c202d206e6f7720746869732061626f6d696e61626c65206265617374206c6976657320696e20612070696e656170706c6520756e64657220746865207365612e0a0a47617279646f73206f6e205355492e2e200a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_4_31cb147bd1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARYDOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARYDOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

