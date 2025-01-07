module 0xc38c6a90f6907e6d140121cab03f9e5bed3285e8b066ffd1287d0c8c695f2a75::gow {
    struct GOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOW>(arg0, 9, b"GOW", b"GdOfWar", b"meme coin in the honor of god of war", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e123c472-24c4-464e-b3eb-5adad8c004e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

