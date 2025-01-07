module 0x68465e8d31f9fd211c852933a843ab5295668d69b37436a86e176ecd96f1deb2::dgc {
    struct DGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGC>(arg0, 9, b"DGC", b"DOGS", b"It is meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d8bf9e5-467e-400a-b921-c36fda1c3891.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

