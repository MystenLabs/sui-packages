module 0x7018d1a25ec7bdb318e792358a5bd9098a0263c6b8851db9b13e5a0e4c926186::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 6, b"Kumo", b"KumoCat", b"A clumsy cat has entered the chat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25f3a6c3c9e642fbcab69596b1e16ffe_4bafa95277.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

