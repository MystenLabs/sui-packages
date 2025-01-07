module 0x28888fcb7aab665960d6d9f8224f8c5098426e1142e390143286be40ab95daca::mover {
    struct MOVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVER>(arg0, 6, b"MOVER", b"MOVE Mascot", x"40426c75654d6f76655f4f41206f6666696369616c206d6173636f740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mover_e1026c017b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

