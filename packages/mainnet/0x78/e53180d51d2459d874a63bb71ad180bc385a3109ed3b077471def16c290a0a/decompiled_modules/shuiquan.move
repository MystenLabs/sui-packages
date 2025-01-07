module 0x78e53180d51d2459d874a63bb71ad180bc385a3109ed3b077471def16c290a0a::shuiquan {
    struct SHUIQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIQUAN>(arg0, 6, b"SHUIQUAN", b"Shui Quan", x"4669727374204368696e65736520646f67200a46697273742053756920636861696e20707265626f6e64656420427579626f74206c6976650a0a40536875695175616e427579426f740a0a53756920546f6f6c7320636f6d696e67206166746572206c61756e6368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026539_4aa314d635.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIQUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

