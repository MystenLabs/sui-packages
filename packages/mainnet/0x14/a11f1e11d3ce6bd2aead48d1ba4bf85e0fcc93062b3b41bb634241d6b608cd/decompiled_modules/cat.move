module 0x14a11f1e11d3ce6bd2aead48d1ba4bf85e0fcc93062b3b41bb634241d6b608cd::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Catty", b"Catty is a meme coin on the Sui blockchain ecosystem, featuring an iconic cat mascot and a strong community focus. As a humor-based token, Catty leverages the appeal of memes and a loyal fan base to stand out among crypto enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973187967.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

