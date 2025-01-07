module 0x89af2df4ceeb97901211d2fea83c199b3c0f2b2ae3dca763bb57304003daa77e::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"suirex | $REX", b"MEME TOKEN LAUNCHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_42c4a7558c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REX>>(v1);
    }

    // decompiled from Move bytecode v6
}

