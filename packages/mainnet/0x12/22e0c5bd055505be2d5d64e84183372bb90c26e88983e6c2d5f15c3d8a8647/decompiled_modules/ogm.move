module 0x1222e0c5bd055505be2d5d64e84183372bb90c26e88983e6c2d5f15c3d8a8647::ogm {
    struct OGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGM>(arg0, 9, b"OGM", b"OG meme", b"Nothing but a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79468d0e-0773-4107-9ab4-07688440b429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

