module 0xba793f620dc5ede0be22868ef99b905481551a68c76e462ff2d48a0a6eb801cf::trpf {
    struct TRPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRPF>(arg0, 9, b"TRPF", b"Trump fx", b"The Forex meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c616f8f-fb47-4087-856c-df8479ff8fa4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

