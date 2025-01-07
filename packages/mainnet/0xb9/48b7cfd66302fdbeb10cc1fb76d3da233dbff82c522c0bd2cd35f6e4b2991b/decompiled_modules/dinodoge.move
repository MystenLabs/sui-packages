module 0xb948b7cfd66302fdbeb10cc1fb76d3da233dbff82c522c0bd2cd35f6e4b2991b::dinodoge {
    struct DINODOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINODOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINODOGE>(arg0, 6, b"DINODOGE", b"DinoDoge on SUI", b"DinoDoge is live, a mix of the famous doge dog and a lovable dinosaur. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qg_L_Em3wp_400x400_ea95eec5d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINODOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINODOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

