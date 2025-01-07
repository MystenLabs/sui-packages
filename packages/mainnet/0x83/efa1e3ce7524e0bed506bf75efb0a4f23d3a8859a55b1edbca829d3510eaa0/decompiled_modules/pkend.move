module 0x83efa1e3ce7524e0bed506bf75efb0a4f23d3a8859a55b1edbca829d3510eaa0::pkend {
    struct PKEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKEND>(arg0, 9, b"PKEND", b"hdjdn", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5191d00-0a34-428a-86be-d14c66ebba3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

