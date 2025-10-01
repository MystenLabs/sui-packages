module 0x41f9f9344cac094454cd574e333c4fdb132d7bcc9379bcd4aab485b2a63942::wbtc {
    struct WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC>(arg0, 8, b"WBTC", b"Wrapped BTC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://etherscan.io/token/images/wrappedbtc_ofc_32.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

