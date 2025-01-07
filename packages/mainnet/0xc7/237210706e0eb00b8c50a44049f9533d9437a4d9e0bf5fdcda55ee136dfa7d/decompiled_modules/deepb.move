module 0xc7237210706e0eb00b8c50a44049f9533d9437a4d9e0bf5fdcda55ee136dfa7d::deepb {
    struct DEEPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPB>(arg0, 6, b"DEEPB", b"DeepBook", b"Deepbook CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_f4d4bd6366.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPB>>(v1);
    }

    // decompiled from Move bytecode v6
}

