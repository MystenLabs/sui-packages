module 0x1b0a7a08395e6295fb052a88b2c435910f5ca9181d49c0b275c435a6dfbdec53::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"USDT", b"USDT", b"WWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/8Mb7Knrx3bk1CSJD2XfGXhN3n6fxAv96jy2uoWE6WzDw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

