module 0xf164bb9a7dd326815288dda796e620b258b493f3756b45006b390994010ace47::babas {
    struct BABAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABAS>(arg0, 9, b"BABAS", b"BABA", b"Baba is a crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d12f3dd-4f7a-48f3-89b7-c7cc78a1ec85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

