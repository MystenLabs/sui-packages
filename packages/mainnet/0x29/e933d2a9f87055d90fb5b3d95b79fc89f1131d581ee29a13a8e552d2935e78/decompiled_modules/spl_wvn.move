module 0x29e933d2a9f87055d90fb5b3d95b79fc89f1131d581ee29a13a8e552d2935e78::spl_wvn {
    struct SPL_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL_WVN>(arg0, 9, b"SPL_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73af17ea-90ba-42b2-b7ce-107fca6368c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

