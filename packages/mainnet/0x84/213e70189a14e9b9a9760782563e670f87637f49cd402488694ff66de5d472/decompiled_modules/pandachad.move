module 0x84213e70189a14e9b9a9760782563e670f87637f49cd402488694ff66de5d472::pandachad {
    struct PANDACHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDACHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDACHAD>(arg0, 6, b"PANDACHAD", b"PANDA CHAD", b"join us and be a chad with pandachad squad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5213_a6ee9068d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDACHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDACHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

