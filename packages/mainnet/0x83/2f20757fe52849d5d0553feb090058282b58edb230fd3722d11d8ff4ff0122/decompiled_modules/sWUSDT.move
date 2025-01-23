module 0x832f20757fe52849d5d0553feb090058282b58edb230fd3722d11d8ff4ff0122::sWUSDT {
    struct SWUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWUSDT>(arg0, 9, b"sysWUSDT", b"SY sWUSDT", b"SY scallop sUSDT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

