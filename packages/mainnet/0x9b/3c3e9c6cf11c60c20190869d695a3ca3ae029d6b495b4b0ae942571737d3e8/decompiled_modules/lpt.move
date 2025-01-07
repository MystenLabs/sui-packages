module 0x9b3c3e9c6cf11c60c20190869d695a3ca3ae029d6b495b4b0ae942571737d3e8::lpt {
    struct LPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPT>(arg0, 9, b"LPT", b"Little Pig", b"Think about meme and rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f61f486-3334-4392-b129-f8e792a31e34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

