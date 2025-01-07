module 0x6aed14aabd33ffd649e90fb0182a2e1983aff090c816aa3a49def3008fea792c::spl_wvn {
    struct SPL_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL_WVN>(arg0, 9, b"SPL_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/325f5083-aafd-41d1-b3ad-a839ddc9727b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

