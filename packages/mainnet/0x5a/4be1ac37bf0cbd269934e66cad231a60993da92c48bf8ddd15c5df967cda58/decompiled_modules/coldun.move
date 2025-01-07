module 0x5a4be1ac37bf0cbd269934e66cad231a60993da92c48bf8ddd15c5df967cda58::coldun {
    struct COLDUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLDUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLDUN>(arg0, 9, b"COLDUN", b"Cooldun10", b"Coldun top prj ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8f2adce-06a6-4d75-a49e-cb5b1b929ad7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLDUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLDUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

