module 0xd3de3a90f852c4792fd604258952481a1ab301758c4a2c0cc7936da77d250b79::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"Aura", b"Sui Aura", x"5375692773206175726120697320696e73616e65207269676874206e6f772c0a6c65742773206b65657020746865206d6f6d656e74756d0a6c6f636b20696e0a2441757261", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfp_38d1d1a791.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

