module 0x843ed6b545a91ee69bcc20dde703161cdce6520e6238c45320da490d6af2754c::pelsn {
    struct PELSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELSN>(arg0, 9, b"PELSN", b"ksnen", b"ehbeb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac8a0d60-8bbb-4eed-aa27-2c4934329792.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PELSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

