module 0xfedcc1636bbbbd68746ac270fd6fbb98a83b7fa7d7a1af5c97d2ba02ca0c93ae::nfl {
    struct NFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFL>(arg0, 6, b"NFL", b"NFL COIN", b"OFFICIAL SUI COIN OF NFL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747929027571.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

