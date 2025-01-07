module 0xcde5fdf22cc9a51b4d5acb93b0f2a2cc6776be2ac64cfea456822ee9e2a64d35::sjt {
    struct SJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJT>(arg0, 6, b"SJT", b"suijeet", b"look of jeets at the time of jeeting their bags mixed with the look of solana holders when sui flips solana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sadness_99d5347da8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

