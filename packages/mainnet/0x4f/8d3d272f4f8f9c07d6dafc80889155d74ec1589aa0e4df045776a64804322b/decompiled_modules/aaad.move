module 0x4f8d3d272f4f8f9c07d6dafc80889155d74ec1589aa0e4df045776a64804322b::aaad {
    struct AAAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAD>(arg0, 6, b"AAAD", b"aaa Deng", b"Can`t stop wan`t stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_16_31_28_ae77757262.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

