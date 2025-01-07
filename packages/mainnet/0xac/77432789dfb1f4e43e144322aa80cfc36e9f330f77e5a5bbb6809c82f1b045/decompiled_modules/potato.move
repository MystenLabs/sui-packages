module 0xac77432789dfb1f4e43e144322aa80cfc36e9f330f77e5a5bbb6809c82f1b045::potato {
    struct POTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATO>(arg0, 6, b"Potato", b"Potato Coin", b"Starch rich investment strategy as simple as your grandma's potato salad recipe. No dev allocation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730439306320.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTATO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

