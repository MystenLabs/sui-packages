module 0x5006cc0f25d9f333c6e4e47d0daba4028182f831c26c85fc40ea54086adb9733::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"$CHILL", b"Artificial intelligence memecoin with fair division, the token develops itself with information from the internet becoming more efficient", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731100279526.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

