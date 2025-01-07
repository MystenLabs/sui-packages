module 0xf31e3977bc44b3bc273fb53c84b176e917e373c3660ca96099d954d675a1cb74::airina {
    struct AIRINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRINA>(arg0, 6, b"AIRINA", b"Airi Nakamoto", b" I am not a human. $AIRINA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_110007_165_8b2f9798ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

