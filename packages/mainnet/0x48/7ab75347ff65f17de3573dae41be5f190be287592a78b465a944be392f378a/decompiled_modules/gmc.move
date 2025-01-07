module 0x487ab75347ff65f17de3573dae41be5f190be287592a78b465a944be392f378a::gmc {
    struct GMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMC>(arg0, 9, b"GMC", b"Grumpy Cat", b"A famous meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8eddc69e-6624-4967-b30f-38141b85b2a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

