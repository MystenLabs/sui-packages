module 0x9ca5ac325c91045c4f7c179e3cfcbc50c45baee80105e530a49e88a571a25830::mindoge {
    struct MINDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINDOGE>(arg0, 9, b"MINDOGE", b"MIN", b"meme of the poddle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2b3caf5-114e-4d4d-bc67-55d3b340e986.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

