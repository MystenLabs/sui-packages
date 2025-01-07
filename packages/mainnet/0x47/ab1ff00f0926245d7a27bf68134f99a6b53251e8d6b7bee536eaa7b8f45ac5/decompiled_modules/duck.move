module 0x47ab1ff00f0926245d7a27bf68134f99a6b53251e8d6b7bee536eaa7b8f45ac5::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"Sui Duck", b"Meet Sui $DUCK, Duck is flying high and quacking loud! This token is leading the flock with its unique vibe and community power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Duck_7956e2800b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

