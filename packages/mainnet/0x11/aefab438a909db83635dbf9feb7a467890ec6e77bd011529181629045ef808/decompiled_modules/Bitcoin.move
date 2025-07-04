module 0x11aefab438a909db83635dbf9feb7a467890ec6e77bd011529181629045ef808::Bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"Bitcoin", b"{\"description\":\"it's a bit of a coin. \",\"twitter\":\"https://twitter.com/bitcoin\",\"website\":\"https://bitcoin.com\",\"telegram\":\"https://t.me/bitcoin\",\"tags\":[\"bit\",\"coin\",\"bitcoin\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9a6d7bc0-8fcf-4ff7-9dd2-bd39fdf8701e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

