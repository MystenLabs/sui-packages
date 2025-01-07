module 0x4ce7c668d033dc8bf2c5f8d7aa141eba7bd15312f80448277b9e83c51fe6e8c8::emo {
    struct EMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMO>(arg0, 6, b"EMO", b"FINDING EMO", b"it's not a phase dad - $emo on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/emo_f82fd50cac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

