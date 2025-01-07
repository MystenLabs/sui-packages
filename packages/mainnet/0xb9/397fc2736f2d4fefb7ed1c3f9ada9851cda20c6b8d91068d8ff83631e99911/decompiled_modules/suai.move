module 0xb9397fc2736f2d4fefb7ed1c3f9ada9851cda20c6b8d91068d8ff83631e99911::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SuAi", b"suAi", b"Sui drop on Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_e7cec9ab69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

