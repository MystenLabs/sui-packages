module 0x54613b9c6a882b7e10d8d2f65bfe378515c3e06cfa79f49877e052e44596ce11::wbtc_test {
    struct WBTC_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC_TEST>(arg0, 6, b"wBTC-TEST", b"wBTC-TEST", b"Wrapped Bitcoin Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/wBTC-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBTC_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

