module 0xdab38b88f375f9357557020da6391e55cbdba6586dbee08eecc5a4381f12c113::hprg {
    struct HPRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPRG>(arg0, 6, b"HPRG", b"HopFrog", b"First Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_546504e529.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

