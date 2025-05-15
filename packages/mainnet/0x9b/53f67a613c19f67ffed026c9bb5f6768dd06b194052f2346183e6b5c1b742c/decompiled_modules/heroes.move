module 0x9b53f67a613c19f67ffed026c9bb5f6768dd06b194052f2346183e6b5c1b742c::heroes {
    struct HEROES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEROES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEROES>(arg0, 6, b"HEROES", b"Sui Heroes", x"537569204865726f6573206275696c7420746f20686f6e6f7220746865207265616c206f6e657320626568696e642074686520636861696e2e0a41207472696275746520746f20616c6c205375692064657673206772696e64696e6720696e2073696c656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifipcnbe4ve5y6etpo7b4de7ycgylw5tcu2rlsciq2ugucmhywwuq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEROES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEROES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

