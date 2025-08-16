module 0x67c359949b0a41eed78833b551a54d2cc4ece8e3b62792f81bba5eee55359b02::stroll {
    struct STROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STROLL>(arg0, 9, b"STROLL", b"Sui Troll", b"Sui Troll on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STROLL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STROLL>>(v2, @0x191726a4470b439a8353879cbcb7a67617e78ef938eb3b8cd5a0cf1cf285ce8f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

