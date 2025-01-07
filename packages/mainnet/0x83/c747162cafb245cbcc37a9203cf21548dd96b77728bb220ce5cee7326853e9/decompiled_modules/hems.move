module 0x83c747162cafb245cbcc37a9203cf21548dd96b77728bb220ce5cee7326853e9::hems {
    struct HEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMS>(arg0, 9, b"HEMS", b"Habila Gul", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f45df87-21b6-4aff-bd1d-bc3e84950902.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

