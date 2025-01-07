module 0x6c71a72c5f225eb1858678481b5ec1e5101163c22c894d7125ae03a4e70525d4::gc {
    struct GC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GC>(arg0, 9, b"GC", b"Game Club", b"Telegram mini app entusiast community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9feb4733-c213-4043-b92e-c81d4a6d2d4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GC>>(v1);
    }

    // decompiled from Move bytecode v6
}

