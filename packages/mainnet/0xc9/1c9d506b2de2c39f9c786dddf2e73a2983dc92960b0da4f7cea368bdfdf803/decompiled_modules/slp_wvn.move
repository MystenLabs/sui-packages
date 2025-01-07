module 0xc91c9d506b2de2c39f9c786dddf2e73a2983dc92960b0da4f7cea368bdfdf803::slp_wvn {
    struct SLP_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLP_WVN>(arg0, 9, b"SLP_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd4a468e-214a-4079-8a9d-f68c61c065d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLP_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLP_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

