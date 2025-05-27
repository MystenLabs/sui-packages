module 0xd1059b57666bf9c9827d9a1d15df7ffd118e7242ead8d4859f068e09c3f0eddc::tweet {
    struct TWEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWEET>(arg0, 6, b"TWEET", b"Tweet", b"Tweet tweet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748364872903.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWEET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWEET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

