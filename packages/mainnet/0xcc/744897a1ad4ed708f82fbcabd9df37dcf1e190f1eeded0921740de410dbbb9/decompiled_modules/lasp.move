module 0xcc744897a1ad4ed708f82fbcabd9df37dcf1e190f1eeded0921740de410dbbb9::lasp {
    struct LASP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASP>(arg0, 9, b"LASP", b"Last Pick", b"Last meme coin by me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce2592ae-aaf6-4d6c-8d99-7415e5e18605.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LASP>>(v1);
    }

    // decompiled from Move bytecode v6
}

