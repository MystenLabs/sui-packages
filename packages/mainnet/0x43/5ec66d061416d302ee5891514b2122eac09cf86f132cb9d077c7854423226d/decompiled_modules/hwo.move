module 0x435ec66d061416d302ee5891514b2122eac09cf86f132cb9d077c7854423226d::hwo {
    struct HWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWO>(arg0, 6, b"HWO", b"HELLO WORLD", b"HWO how are you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihaso3rtthdk65kwh3rk7ji2kdiyegxvzgsjyj62eaeelsv47txbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

