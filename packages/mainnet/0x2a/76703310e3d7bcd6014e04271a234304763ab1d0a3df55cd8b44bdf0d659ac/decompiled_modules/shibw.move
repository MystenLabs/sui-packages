module 0x2a76703310e3d7bcd6014e04271a234304763ab1d0a3df55cd8b44bdf0d659ac::shibw {
    struct SHIBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBW>(arg0, 9, b"SHIBW", b"SHIBA WAVE", b"BEST MEME OF THE YEAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b94b7155-5895-463c-9a30-d5be3a3ad654.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

