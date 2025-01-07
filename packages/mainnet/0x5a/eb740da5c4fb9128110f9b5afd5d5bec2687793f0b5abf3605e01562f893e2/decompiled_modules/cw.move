module 0x5aeb740da5c4fb9128110f9b5afd5d5bec2687793f0b5abf3605e01562f893e2::cw {
    struct CW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CW>(arg0, 9, b"CW", b"CryptoWave", b"CryptoWave is an innovative blockchain-based token created to promote decentralized financial solutions and ensure secure transactions. Its goal is to connect users and investors into a single ecosystem, offering convenient tools for trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cce78b0-6831-4caa-aa14-1e1a0ed73674.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CW>>(v1);
    }

    // decompiled from Move bytecode v6
}

