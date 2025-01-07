module 0x8e2c2d4796006a978cf4523d04963ff30e625a0cd5f00b5858973d9f64178311::aaaaaaaaaaaaaaaaaaaaaa {
    struct AAAAAAAAAAAAAAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAAAAAAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAAAAAAAAAAAAAAAAA>(arg0, 6, b"AAAAAAAAAAAAAAAAAAAAAA", b"SUI NARUTO AAAAAAAAAAA", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/naturo_2ae797f5aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAAAAAAAAAAAAAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAAAAAAAAAAAAAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

