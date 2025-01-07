module 0x3a2ef73a4b8cfa1d868a17dab2c3588eaad1a080ebbf03bd28395a27db7b025b::ide {
    struct IDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDE>(arg0, 9, b"IDE", b"Good Idea", b"Meme of Some Good Idea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba1ed551-d8ce-45f9-bb39-65e5cdf06d43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

