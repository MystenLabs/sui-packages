module 0x3bb0d6bd12260bc0f94738001b63bb00a791f262fa3f3dba7ffdc7eaf850a0ac::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIZA>(arg0, 6, b"ELIZA", b"elizaOS", b"Autonomous AI agents for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eliza_689d10b870.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

