module 0x36d2dd799449c18f22dedff9dbd0b45d9924253c595268b4ad737327a2d97ae8::obama {
    struct OBAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBAMA>(arg0, 9, b"OBAMA", b"HPOS10inu", b"HarryPotterObamaSonic10Inu in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce32a349-bc23-48e5-b442-91d39b5e7b17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

