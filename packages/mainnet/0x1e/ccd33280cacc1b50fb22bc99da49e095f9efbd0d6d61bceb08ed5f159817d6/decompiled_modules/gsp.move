module 0x1eccd33280cacc1b50fb22bc99da49e095f9efbd0d6d61bceb08ed5f159817d6::gsp {
    struct GSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSP>(arg0, 9, b"GSP", b"gods speed", b"Fast and furious support community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df718901-3e29-4e83-9361-bad68a1d9a7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

