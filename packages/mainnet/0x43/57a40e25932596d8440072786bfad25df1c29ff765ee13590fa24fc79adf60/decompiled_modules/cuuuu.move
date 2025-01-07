module 0x4357a40e25932596d8440072786bfad25df1c29ff765ee13590fa24fc79adf60::cuuuu {
    struct CUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUUUU>(arg0, 9, b"CUUUU", b"cuucuu", b"CUUUUAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46d9f41c-ea9f-4b13-b99d-ab41a015bed7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

