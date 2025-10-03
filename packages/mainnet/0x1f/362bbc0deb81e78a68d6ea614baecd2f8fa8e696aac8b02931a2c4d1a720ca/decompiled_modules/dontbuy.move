module 0x1f362bbc0deb81e78a68d6ea614baecd2f8fa8e696aac8b02931a2c4d1a720ca::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 6, b"DONTBUY", b"Dont Buy", b"Do not buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif2cplsyaa5svbi3ordsj2ahr2ut5kvjpnfm37bhy2aggzwqemu3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONTBUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

