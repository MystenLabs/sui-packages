module 0x9c3e601c0d5b6f1c5d7a208572f0bf497a1868b16abaffd69bed184d54e90435::hdowwwg {
    struct HDOWWWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOWWWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOWWWG>(arg0, 6, b"HDOwwwg", b"HD", b"Hd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005438669.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDOWWWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDOWWWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

