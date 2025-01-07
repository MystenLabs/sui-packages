module 0xc12afc3e362871462aa0883be8dccbdc265c358d047587bb0870a68c87e3044d::dfas {
    struct DFAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFAS>(arg0, 9, b"DFAS", b"KJHFDS", b"BBCV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/405600e4-099d-4ea0-9366-febaf4dce6d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

