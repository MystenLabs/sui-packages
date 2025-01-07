module 0x63988e364763943ce48c8ecb987e67f762991df4307b98fb92e34d86a8d33958::fuk {
    struct FUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUK>(arg0, 6, b"Fuk", b"Hello kitty", b"Queen bitch kitty ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9399_148dd645c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

