module 0x3d966164d37500af33d40ac59b0d79d7a04fc4ca445d5536c81c505c4f6bd838::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIZA>(arg0, 6, b"eliza", b"ELIZA", b"Autonomous agents for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eliza_689d10b870.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

