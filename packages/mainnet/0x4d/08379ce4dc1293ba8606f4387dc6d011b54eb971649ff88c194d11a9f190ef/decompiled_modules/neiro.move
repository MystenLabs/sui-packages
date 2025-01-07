module 0x4d08379ce4dc1293ba8606f4387dc6d011b54eb971649ff88c194d11a9f190ef::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Neiro", b"Sui needs a neiro that wont get rugged", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_77ab73baf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

