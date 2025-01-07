module 0x4ab59a0bc41eb9d55c6cdeeb18ab1b80195a105d51f98b133cfcc455803eeda2::huevos {
    struct HUEVOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUEVOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUEVOS>(arg0, 6, b"HUEVOS", b"HUEVOS ON SUI", b"Dexscreener Paid.Join now: https://www.huevosonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BTC_2_207dea3fa8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUEVOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUEVOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

