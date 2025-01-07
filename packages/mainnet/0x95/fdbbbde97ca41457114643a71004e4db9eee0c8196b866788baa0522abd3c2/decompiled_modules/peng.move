module 0x95fdbbbde97ca41457114643a71004e4db9eee0c8196b866788baa0522abd3c2::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"PENGSUIN", x"54686520636f6f6c657374206d656d65636f696e206f6e20535549200a506f776572656420627920636f6d6d756e69747920262070656e6775696e207669626573200a4a6f696e20746865206368696c6c6573742063727970746f2066616d2026206c65747320736f617220746f20746865206d6f6f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U3b4_Aa_X_400x400_9d108103bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

