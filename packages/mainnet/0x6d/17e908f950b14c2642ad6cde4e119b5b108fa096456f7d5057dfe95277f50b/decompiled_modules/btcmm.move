module 0x6d17e908f950b14c2642ad6cde4e119b5b108fa096456f7d5057dfe95277f50b::btcmm {
    struct BTCMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCMM>(arg0, 9, b"BTCMM", b"BTC Meme", b"BTC is King of meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b0f74dd-37ca-41c2-8457-b678771d1b93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

