module 0x87fde8c5f7c21ef7452f4e6f255d55e4848c180e116b90bca4dea7242d77f9bc::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"Ghost Halloween", b"Ghost Halloween coming to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979915806.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

