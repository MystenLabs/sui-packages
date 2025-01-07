module 0x53fdd3d1e26e47529e46e228086cb2a8c290b2130cc5f99c8e6d5dab3d8f6578::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 6, b"Marie", b"Marie Rose", b"We compress the entire stock market into resilient cryptographic internet coins, employing Ethereum Science Technologies alongside the quantum entanglement-driven Multi-Dimensional Hashing Algorithm (MDHA).  For more details email Marie Rose #SPX6900 #flipathestockmarket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marie_3fff749f06.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

