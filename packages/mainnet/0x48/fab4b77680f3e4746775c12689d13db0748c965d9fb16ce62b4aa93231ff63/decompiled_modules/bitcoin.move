module 0x48fab4b77680f3e4746775c12689d13db0748c965d9fb16ce62b4aa93231ff63::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"bitcoin", b"{\"description\":\"bitcoin bitcoin bitcoin. you heard it mfer. it's a bit of a coin. \",\"twitter\":\"https://twitter.com/bitcoin\",\"website\":\"https://bitcoin.com\",\"telegram\":\"https://t.me/bitcoin\",\"tags\":[\"bitcoin\",\"coin\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4908fefb-9f16-4a55-8dd7-6fad6ac1dae0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

