module 0x93338fb02dd972c0f81890ad90b5d506444423250e6ebb56af66d7f2ff446391::ptm {
    struct PTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTM>(arg0, 9, b"PTM", b"puttome", b"put to talk or siren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a898401-3e00-40c4-87a5-cc52a78d30a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

