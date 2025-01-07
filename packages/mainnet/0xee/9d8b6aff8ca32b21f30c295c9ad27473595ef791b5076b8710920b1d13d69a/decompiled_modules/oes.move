module 0xee9d8b6aff8ca32b21f30c295c9ad27473595ef791b5076b8710920b1d13d69a::oes {
    struct OES has drop {
        dummy_field: bool,
    }

    fun init(arg0: OES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OES>(arg0, 6, b"Oes", b"One eye sui", b"Eye on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000904590_d86bb3bd60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OES>>(v1);
    }

    // decompiled from Move bytecode v6
}

