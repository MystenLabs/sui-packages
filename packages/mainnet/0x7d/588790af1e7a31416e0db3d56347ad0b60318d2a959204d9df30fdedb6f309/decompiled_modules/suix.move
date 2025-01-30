module 0x7d588790af1e7a31416e0db3d56347ad0b60318d2a959204d9df30fdedb6f309::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"Sui100", x"f09f94a52046697273742041492058206167656e74206f6e2073756920706f776572656420627920446565705365656b2d5231", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738246494127.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

