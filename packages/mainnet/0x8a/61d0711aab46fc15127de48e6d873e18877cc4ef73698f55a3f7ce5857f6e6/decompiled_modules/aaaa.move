module 0x8a61d0711aab46fc15127de48e6d873e18877cc4ef73698f55a3f7ce5857f6e6::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 6, b"AAAA", b"AAA", b"AAA aaa AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_f6359a2826.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

