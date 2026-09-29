module 0x43292cc1de0af9ff32d60c8ffc5ef33c8c55e3236720f965006aed26127ca402::nyaaa {
    struct NYAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAAA>(arg0, 9, b"NYAAA", b":3", b"NYAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/14d3e38ccc690fe34de3692e3a5442e65085a924f16a19dafc4117195b813f76")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NYAAA>>(0x2::coin::mint<NYAAA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYAAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAAA>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

