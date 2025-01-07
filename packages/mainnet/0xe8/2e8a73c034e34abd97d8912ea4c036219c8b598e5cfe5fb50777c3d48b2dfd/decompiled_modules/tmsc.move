module 0xe82e8a73c034e34abd97d8912ea4c036219c8b598e5cfe5fb50777c3d48b2dfd::tmsc {
    struct TMSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMSC>(arg0, 9, b"TMSC", b"TOMASCAT", b"Memcoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc780b21-fa74-41d8-afa3-8e66d39c06b9-IMG_7358.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

