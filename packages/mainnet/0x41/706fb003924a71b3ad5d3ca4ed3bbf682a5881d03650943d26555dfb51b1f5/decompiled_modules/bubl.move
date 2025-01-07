module 0x41706fb003924a71b3ad5d3ca4ed3bbf682a5881d03650943d26555dfb51b1f5::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"Bubl", b"HAVE FUN WITH BUBBLE SOAR WITH BUBBLE BUBBLE IT! BUBBLES ARE EVERYWHERE WATER IS, AND SUI IS NO EXCEPTION!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731343798256.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

