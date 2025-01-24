module 0x5310f211de153a63361e7dbb60b480c4e27de48a53d027a6b691aaa2ecd9e179::vidio {
    struct VIDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIDIO>(arg0, 6, b"VIDIO", b"VIDIO", b"VIDIO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737715371229-vdiao.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIDIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

