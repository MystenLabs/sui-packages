module 0xfe0e720188e265cc01cfb06b6b79b76f0e8e8258ba7e42e81c57083bbeb81545::heavens {
    struct HEAVENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAVENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAVENS>(arg0, 9, b"HEAVENS", b"Heaven", b"A god meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/222c56c4-aa89-4cf3-bbba-8ab54ec1b42b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAVENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAVENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

