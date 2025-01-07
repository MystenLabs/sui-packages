module 0x8e10181eba75fee2d68c41069f0a363641de5c4fcd6cfbb83242200c6e30b022::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Hoppy on SUI", b"The bunny full of Energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731448949874.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

