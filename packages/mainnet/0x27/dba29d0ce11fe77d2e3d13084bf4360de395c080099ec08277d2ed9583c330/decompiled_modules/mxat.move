module 0x27dba29d0ce11fe77d2e3d13084bf4360de395c080099ec08277d2ed9583c330::mxat {
    struct MXAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXAT>(arg0, 9, b"MXAT", b"Meme", b"Usuahsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ea39701-69bc-4869-8826-9cc4df8b802b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

