module 0x856e1855f4fbace6df544ed7689d43a2574c156659e9162d1a30a2d9ead673b9::riwbe {
    struct RIWBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIWBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIWBE>(arg0, 9, b"RIWBE", b"jsjd", b"jxnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b31371fa-18de-4990-a72d-c77e9c3a0208.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIWBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIWBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

