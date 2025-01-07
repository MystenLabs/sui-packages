module 0x77d07884533093a798c1cb03b2db46b565d59994d4fba8dcc75b9da66074fc29::spl_wvn {
    struct SPL_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL_WVN>(arg0, 9, b"SPL_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11e4ff76-2bf7-4784-a961-af78774c6988.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

