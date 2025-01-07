module 0x9e75fe7974325b86477c93f7f8a2c4b82a8f2b7e9900e818e1b00a5b6636a943::futai {
    struct FUTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTAI>(arg0, 9, b"FUTAI", b"FUTURE AI", b"FutAI is a community-driven meme token representing the fusion of artificial intelligence and futuristic innovation. It's a decentralized, deflationary token empowering AI advancements and humorous robot memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce905cc8-6602-4fbe-acd7-827f0b33cfb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

