module 0x2ced7d353b803fd1e75c2f28d51ad82b88b16d068d6556593abee4d68dfaef7d::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 6, b"MemeFi", b"MEMEFI", x"4c656164696e672054656c656772616d2067616d696e672065636f73797374656d2077697468206f7665722035304d2075736572730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023147_313f7d9904.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

