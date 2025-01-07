module 0x48ae1425d40f059bce3ddef05e1b06d70379cfca93f04e316ef357a3edf443aa::ov {
    struct OV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OV>(arg0, 9, b"OV", b"Oval ", b"Talks about the beauty of women ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a65d9858-fcaa-4c89-8410-c86b62deff45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OV>>(v1);
    }

    // decompiled from Move bytecode v6
}

