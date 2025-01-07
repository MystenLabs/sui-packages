module 0x8b99c5ac52ed7a4f606cd438a400c99aac5c48a39326b9d3b7fa3d37c61d9395::dann {
    struct DANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANN>(arg0, 6, b"DANN", b"DANN THE DEMON", x"48697320646179206a6f62206173206120736c65657020706172616c797369732064656d6f6e207761736e277420706179696e67207468652062696c6c732e20736f206e6f7720686520747261646573206d656d6520636f696e732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_I_Sg8_QGG_400x400_662bcd972d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

