module 0xd32963c9efa3669d35236e8e1b5ae9c71f7c9a8fe3d0cdf30e631bf2362cd1a1::spl_wvn {
    struct SPL_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL_WVN>(arg0, 9, b"SPL_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef4ceac0-96d7-45d9-b749-a06f84874570.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

