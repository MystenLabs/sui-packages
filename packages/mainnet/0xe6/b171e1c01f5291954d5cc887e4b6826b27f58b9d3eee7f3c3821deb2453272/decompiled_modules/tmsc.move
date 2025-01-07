module 0xe6b171e1c01f5291954d5cc887e4b6826b27f58b9d3eee7f3c3821deb2453272::tmsc {
    struct TMSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMSC>(arg0, 9, b"TMSC", b"TOMASCAT", b"Memcoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43ef0533-ab08-4218-90b6-c6aaa9e76838-IMG_7358.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

