module 0x70e07d1ddacff87a3e6847b1cdf2719d6c66f30b9617798a8b9588956004157f::testet {
    struct TESTET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTET>(arg0, 6, b"TESTET", b"test", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732385144884.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

