module 0xafde305b873f615e152502e35d40953b28e5daf5eb9dff945bb25dbf1d07fe96::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"bitcoin", b"{\"description\":\"bitcoin is here to stay. \",\"twitter\":\"https://twitter.com/bitcoin\",\"website\":\"https://bitcoin.com\",\"telegram\":\"https://t.me/bitcoin\",\"tags\":[\"bitcoin\",\"bit\",\"coinage\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3b4795e7-e84e-40b8-b587-f49f1fff6ae0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

