module 0xdd8bdbb25df6f1de8307ab7333693556a7b31a3af10febf591868def71230653::pengi {
    struct PENGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGI>(arg0, 6, b"Pengi", b"Pengi CTO", b"Pengi is the most brutal on Sui. Fish are afraid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5175_b58d2cb405.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

