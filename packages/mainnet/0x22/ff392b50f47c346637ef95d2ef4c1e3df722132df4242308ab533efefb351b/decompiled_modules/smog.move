module 0x22ff392b50f47c346637ef95d2ef4c1e3df722132df4242308ab533efefb351b::smog {
    struct SMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOG>(arg0, 6, b"SMOG", b"SUI MOG", x"4d4f47206d616b657320686973206465627574206f6e20535549204e6574776f726b2e2e2e200a0a24534d4f470a4c657427732053454e44207468697320686967686572210a0a7765627369746520636f6d696e6720736f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/savedddoua_331ef6430f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

