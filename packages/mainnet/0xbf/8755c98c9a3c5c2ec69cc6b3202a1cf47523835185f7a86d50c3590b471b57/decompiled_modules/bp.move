module 0xbf8755c98c9a3c5c2ec69cc6b3202a1cf47523835185f7a86d50c3590b471b57::bp {
    struct BP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BP>(arg0, 9, b"BP", b"Black Pink", b"Black Pink Singer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b714be93-2f4a-4ab3-bfc3-11846e2255a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BP>>(v1);
    }

    // decompiled from Move bytecode v6
}

