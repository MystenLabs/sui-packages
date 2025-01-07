module 0xcb17c4af96f2c6a828b18b6c3df0a93a04ddbaad9e7f8a590ec503321ce0a7::asdas {
    struct ASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAS>(arg0, 9, b"ASDAS", b"fgfg", b"DGFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/238ba8bf-2849-436f-a6a2-d583cc4bee6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

