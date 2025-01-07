module 0x7f72ff9f40065126a9555b7f1ac617c6ae5a017e94ec92368a869561a30d3a41::rs {
    struct RS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RS>(arg0, 9, b"RS", b"Rockystar", b"This meme coin will take your trading to the next level", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eea467ca-e943-4984-816f-56bf69fbfbac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RS>>(v1);
    }

    // decompiled from Move bytecode v6
}

