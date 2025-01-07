module 0xbd17a5fd9472c8fe07c426e29f35b7ab2fb4dcefea8711c56b4c9bee6b008324::jacg {
    struct JACG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACG>(arg0, 6, b"JACG", b"just a chill guy", b"okay man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/448341794_479900251271013_1412783867946287549_n_ede36d4c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACG>>(v1);
    }

    // decompiled from Move bytecode v6
}

