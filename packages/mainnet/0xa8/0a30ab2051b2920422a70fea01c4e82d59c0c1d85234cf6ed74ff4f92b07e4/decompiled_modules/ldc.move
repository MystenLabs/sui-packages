module 0xa80a30ab2051b2920422a70fea01c4e82d59c0c1d85234cf6ed74ff4f92b07e4::ldc {
    struct LDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDC>(arg0, 6, b"LDC", b"Liberation Day Coin", b"Freedom is the way, Blockchain is our tool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RTM_Blog_Post_liberation_Day_6dc7f229fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

