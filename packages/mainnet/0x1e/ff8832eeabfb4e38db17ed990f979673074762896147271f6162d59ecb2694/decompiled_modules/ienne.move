module 0x1eff8832eeabfb4e38db17ed990f979673074762896147271f6162d59ecb2694::ienne {
    struct IENNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENNE>(arg0, 9, b"IENNE", b"bdbd", b"bdbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91400410-530f-4a01-92e7-80d089c0de40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

