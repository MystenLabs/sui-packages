module 0x16fc9bb4a537e6e6b8f713ae789292b303e227fb02ce181f0135c3fde69aeec9::jkhg {
    struct JKHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKHG>(arg0, 9, b"JKHG", b"ASDAS", b"VBCCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd80a7ed-5232-4676-a92f-626790bebfeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

