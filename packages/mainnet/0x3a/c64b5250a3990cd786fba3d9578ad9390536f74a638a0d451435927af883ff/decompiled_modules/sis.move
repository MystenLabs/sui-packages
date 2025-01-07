module 0x3ac64b5250a3990cd786fba3d9578ad9390536f74a638a0d451435927af883ff::sis {
    struct SIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIS>(arg0, 9, b"SIS", b"Sistem", b"Best token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d839c365-465b-40aa-a870-ac9272522a88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

