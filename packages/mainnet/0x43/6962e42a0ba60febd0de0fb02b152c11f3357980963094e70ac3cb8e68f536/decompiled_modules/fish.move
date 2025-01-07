module 0x436962e42a0ba60febd0de0fb02b152c11f3357980963094e70ac3cb8e68f536::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"suiFISH", b"Fishiest man on the block.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_e4114c57d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

