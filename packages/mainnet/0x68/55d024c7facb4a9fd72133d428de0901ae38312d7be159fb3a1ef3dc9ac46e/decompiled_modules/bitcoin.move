module 0x6855d024c7facb4a9fd72133d428de0901ae38312d7be159fb3a1ef3dc9ac46e::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"bitcoin", b"{\"description\":\"bitcoin is here to stay.but remember, that it's just a bit of a coin. \",\"twitter\":\"https://twitter.com/bitcoin\",\"website\":\"https://bitcoin.com\",\"telegram\":\"https://t.me/bitcoin\",\"tags\":[\"bitcoin\",\"bit\",\"coin\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/62c8a165-4e8c-4b7b-b4ae-495e708e015d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

