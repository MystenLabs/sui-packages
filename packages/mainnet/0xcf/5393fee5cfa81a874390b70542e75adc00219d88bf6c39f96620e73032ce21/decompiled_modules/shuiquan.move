module 0xcf5393fee5cfa81a874390b70542e75adc00219d88bf6c39f96620e73032ce21::shuiquan {
    struct SHUIQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIQUAN>(arg0, 6, b"SHUIQUAN", b"Shui Quan", x"4669727374204368696e65736520646f67206f6e20737569200a0a46697273742053756920636861696e20707265626f6e64656420427579626f74206973206c697665200a0a40536875695175616e427579426f740a0a537569746f6f6c7320636f6d696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026539_246f98ca13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIQUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

