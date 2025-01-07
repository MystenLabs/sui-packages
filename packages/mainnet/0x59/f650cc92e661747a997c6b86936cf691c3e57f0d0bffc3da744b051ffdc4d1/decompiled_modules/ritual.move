module 0x59f650cc92e661747a997c6b86936cf691c3e57f0d0bffc3da744b051ffdc4d1::ritual {
    struct RITUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RITUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RITUAL>(arg0, 6, b"RITUAL", b"RITUALB", b"First Farcaster AI Agent powered by $HIGHER community The token would be meaningless without the shared belief in its significance. We believe. This is a $RITUAL to form a cult.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x117b10cbef43aca09e63a2f9427f73cb67224678_c559d44636.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RITUAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RITUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

