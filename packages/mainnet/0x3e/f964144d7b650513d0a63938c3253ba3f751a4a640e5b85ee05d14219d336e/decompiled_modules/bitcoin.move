module 0x3ef964144d7b650513d0a63938c3253ba3f751a4a640e5b85ee05d14219d336e::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"bitcoin", b"{\"description\":\"bitcoin is here to stay.but remember, that it's just a bit of a coin. \",\"twitter\":\"https://twitter.com/bitcoin\",\"website\":\"https://bitcoin.com\",\"telegram\":\"https://t.me/bitcoin\",\"tags\":[\"bitcoin\",\"bit\",\"coin\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/bb15abd9-f5f1-4244-91a5-df88b400fcf4.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

