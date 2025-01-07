module 0xf55e4aa82a6c85003a9dc8057109c6b5fce40ce0cade2d5328def3c70d585a8f::tsuift {
    struct TSUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUIFT>(arg0, 6, b"TSUIft", b"Taylor SUIft", x"546865206669727374205461796c6f72207377696674206d656d65206f6e205375690a54672c205477697474657220616e642077656273697465206f6e6365206f6e20626c75656d6f7665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tsuift2_fa08f15069.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

