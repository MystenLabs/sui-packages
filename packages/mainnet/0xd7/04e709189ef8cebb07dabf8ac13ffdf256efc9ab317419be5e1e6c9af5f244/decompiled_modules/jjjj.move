module 0xd704e709189ef8cebb07dabf8ac13ffdf256efc9ab317419be5e1e6c9af5f244::jjjj {
    struct JJJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJJJ>(arg0, 9, b"JJJJ", b"Hhhh", b"Vhhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1451ed46-7b05-4988-9209-da50971fb0f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJJJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJJJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

