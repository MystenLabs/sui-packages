module 0xc81981541e600814b2fb3f5f4dc4424131e8fcdf7ee29434b421f04ed42018f3::fmfmf {
    struct FMFMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMFMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMFMF>(arg0, 9, b"FMFMF", b"Kfjfmfm", b"Fmfmfm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6503b22c-9db6-4b74-94f4-2b6b0f1f8dae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMFMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMFMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

