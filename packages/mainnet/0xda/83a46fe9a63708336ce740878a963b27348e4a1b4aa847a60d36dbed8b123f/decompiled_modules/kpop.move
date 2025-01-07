module 0xda83a46fe9a63708336ce740878a963b27348e4a1b4aa847a60d36dbed8b123f::kpop {
    struct KPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPOP>(arg0, 6, b"KPOP", b"Kpop korean Popping", b"K-pop is popping Korea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051045_99f114c6e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

