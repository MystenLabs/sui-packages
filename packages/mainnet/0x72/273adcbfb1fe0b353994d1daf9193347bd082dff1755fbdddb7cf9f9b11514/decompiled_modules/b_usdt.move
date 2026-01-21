module 0x72273adcbfb1fe0b353994d1daf9193347bd082dff1755fbdddb7cf9f9b11514::b_usdt {
    struct B_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDT>(arg0, 9, b"bUSDT", b"bToken USDT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

