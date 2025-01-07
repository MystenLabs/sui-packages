module 0x8d2ecf525fafade5fbc149473b6d38f9206c7dcf67278fe7cc773a0f78070b5a::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 6, b"PINKY", b"Pinky the Pineapple", b"Pinky the happy Pineapple ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_BXS_3_NO_2_400x400_efd0556e51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

