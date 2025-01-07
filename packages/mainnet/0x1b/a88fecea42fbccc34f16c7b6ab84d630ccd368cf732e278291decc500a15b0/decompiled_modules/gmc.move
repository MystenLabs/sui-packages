module 0x1ba88fecea42fbccc34f16c7b6ab84d630ccd368cf732e278291decc500a15b0::gmc {
    struct GMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMC>(arg0, 9, b"GMC", b"Grumpy Cat", b"A famous meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d83f143-3c4a-4eb1-b3ed-2489cfa72b66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

