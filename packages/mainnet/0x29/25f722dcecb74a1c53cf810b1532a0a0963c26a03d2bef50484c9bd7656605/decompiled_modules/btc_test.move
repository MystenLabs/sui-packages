module 0x2925f722dcecb74a1c53cf810b1532a0a0963c26a03d2bef50484c9bd7656605::btc_test {
    struct BTC_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC_TEST>(arg0, 8, b"BTC_TEST", b"BTC Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTC_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

