module 0x5d1a6816681533f45c9dbabf089cce6b00d16871e8c277081338ae64846e9fdb::litch {
    struct LITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITCH>(arg0, 6, b"LITCH", b"Litch Dragon", b"When the frost dragon awakens, the world will kneel. The Litch King has spoken.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038073_0cf1b6c3ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

