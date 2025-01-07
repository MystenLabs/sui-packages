module 0x8a93c2cbe404dc5325c18704e8f1b75f8f05cbb8862a68edf709c35e0cd72152::grdt {
    struct GRDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRDT>(arg0, 9, b"GRDT", b"Get Rich or Die Tryin", b"Get Rich or Die Tryin is a community coin with no intrinsic value or expectation of financial return. There is no formal team or roadmap. The coin is for entertainment purposes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JluCBTP.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRDT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRDT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

