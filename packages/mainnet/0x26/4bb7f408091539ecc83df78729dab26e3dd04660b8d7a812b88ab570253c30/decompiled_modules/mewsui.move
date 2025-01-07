module 0x264bb7f408091539ecc83df78729dab26e3dd04660b8d7a812b88ab570253c30::mewsui {
    struct MEWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWSUI>(arg0, 9, b"MEWSUI", b"JustinMoon", b"Mew mew mew !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2b6506c-9380-4da6-8a31-8f53a2180d86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

