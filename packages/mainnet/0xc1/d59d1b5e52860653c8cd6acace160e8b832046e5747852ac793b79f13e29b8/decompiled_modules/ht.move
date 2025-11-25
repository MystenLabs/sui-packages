module 0xc1d59d1b5e52860653c8cd6acace160e8b832046e5747852ac793b79f13e29b8::ht {
    struct HT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HT>(arg0, 6, b"HT", b"huyN", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1764059399201.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

