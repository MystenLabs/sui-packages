module 0xeed9888b793183885701844c52b37ec5f83011d2ccb06e3fb4df2c78ecc69420::dfgdf {
    struct DFGDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFGDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFGDF>(arg0, 6, b"DFGDF", b"dfhd", b"sdgsdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984784271.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFGDF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFGDF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

