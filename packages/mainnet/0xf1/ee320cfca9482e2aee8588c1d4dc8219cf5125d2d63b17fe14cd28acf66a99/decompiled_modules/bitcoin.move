module 0xf1ee320cfca9482e2aee8588c1d4dc8219cf5125d2d63b17fe14cd28acf66a99::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"bitcoin", b"{\"description\":\"just a bit of a coin. buy it or fuck off. \",\"twitter\":\"https://twitter.com/bitcoin\",\"website\":\"https://bitcoim.com\",\"telegram\":\"https://t.me/bitcoin\",\"tags\":[\"bitcoin\",\"bit\",\"of\",\"coin\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/c8d19f62-eb1f-4239-a098-c429619e1c91.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

