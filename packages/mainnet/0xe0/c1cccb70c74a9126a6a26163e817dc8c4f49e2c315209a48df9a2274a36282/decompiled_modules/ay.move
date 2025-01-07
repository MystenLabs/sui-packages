module 0xe0c1cccb70c74a9126a6a26163e817dc8c4f49e2c315209a48df9a2274a36282::ay {
    struct AY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AY>(arg0, 9, b"AY", b"AYU", b"A meme coin build on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9e58228-09f3-40d7-a35b-9a79ed557d85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AY>>(v1);
    }

    // decompiled from Move bytecode v6
}

