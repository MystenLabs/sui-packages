module 0x434f44a43150dc1ca092fc338e2bfb77b4d1d4c059a22b28010864aafd6d45a5::maye {
    struct MAYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYE>(arg0, 9, b"MAYE", b"Musk", b"Maye Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d330bdfa-e591-4c2f-bbd2-e5366ef9bad4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

