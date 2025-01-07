module 0x6c16d59c97caaa0820ccc30e8b79dca01cb006ad7b95a2998e71ecd8b9eb5098::nimge {
    struct NIMGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIMGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIMGE>(arg0, 6, b"NIMGE", b"NO IMAGE", b"NO NO NO image", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_questions_930ec8ec4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIMGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIMGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

