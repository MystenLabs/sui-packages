module 0x4c6c05ce873ede700c9d022ef3406fa3e7b3e350d4d5e38f15fc901dac454b87::squan {
    struct SQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAN>(arg0, 6, b"SQUAN", b"Sui Quan", x"4368696e65736520646f670a0a46697273742070726520626f6e64656420427579626f74206973206c6976650a40536875695175616e427579426f740a0a53756920746f6f6c7320636f6d696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026539_b32ccdea09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

