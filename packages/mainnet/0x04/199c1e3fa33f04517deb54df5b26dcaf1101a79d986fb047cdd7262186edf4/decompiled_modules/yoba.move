module 0x4199c1e3fa33f04517deb54df5b26dcaf1101a79d986fb047cdd7262186edf4::yoba {
    struct YOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOBA>(arg0, 6, b"YOBA", b"Yoba Coin", b"Oh you missed doge and shib? Check out $YOBA . Who knows, it might be the next big thing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048337_54a3613446.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

