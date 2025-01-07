module 0xff9ef977ce54b15118a1cb0cf171b115db6b71893d51f285691125e2e7b3eb2b::mioc {
    struct MIOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOC>(arg0, 9, b"MIOC", b"Miocats", x"4d696f206361747320676f20746f206d6f6f6e20f09f8c9920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9fd88ca-6b8c-415b-944a-664f386cf718.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

