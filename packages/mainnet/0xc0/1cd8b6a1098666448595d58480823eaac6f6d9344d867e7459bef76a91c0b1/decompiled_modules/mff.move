module 0xc01cd8b6a1098666448595d58480823eaac6f6d9344d867e7459bef76a91c0b1::mff {
    struct MFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFF>(arg0, 6, b"MFF", b"MFF TURBO", b"Welcome to MFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960125264.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

