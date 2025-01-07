module 0x1d6216054ee95aecb5fd7349fc3d79210a0a517d7665803f055006b55e2a34b4::virsu {
    struct VIRSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIRSU>(arg0, 9, b"VIRSU", b"VIRSUI", b"SUI VIRUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1a44d22-88a0-4784-ae49-b587f3bb7dc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIRSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

