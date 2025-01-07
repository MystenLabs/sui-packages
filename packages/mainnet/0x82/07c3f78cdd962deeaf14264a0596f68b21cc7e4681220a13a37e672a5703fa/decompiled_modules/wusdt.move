module 0x8207c3f78cdd962deeaf14264a0596f68b21cc7e4681220a13a37e672a5703fa::wusdt {
    struct WUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSDT>(arg0, 6, b"WUSDT", b"USDT", b"A new stable coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2576_729cd632fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

