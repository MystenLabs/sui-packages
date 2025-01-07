module 0x91f26deb5ce2a07ec6264241b2d1195e651be2af07a533c4b0dea65fc43444a5::suwf {
    struct SUWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWF>(arg0, 9, b"SUWF", b"SUIwifey", b"Bringing back the times of real men and real women. Upholding real societal norms and values.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43602726-e745-4124-8df2-e3c1a32d04d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

