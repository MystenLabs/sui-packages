module 0x7a6b9a1b2c73398c4d8d7716e443cabc2d669da9154c2de348952f6ce1b24ddb::nigaaa {
    struct NIGAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGAAA>(arg0, 6, b"NIGAAA", b"Nigaaa", b"Nigaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_16_31_28_308842e504.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

