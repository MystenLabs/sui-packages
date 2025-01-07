module 0x19cb3e599a17e76574b202ddc070ca8926053efc176f197ab72f5a56de15fb8a::ddeafea {
    struct DDEAFEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDEAFEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDEAFEA>(arg0, 6, b"DDEAFEA", b"ddddafe", b"adfadfasdfasdfasdff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/l1nFu-l-LPIxm3kytgWM8CzOueq2FuGe9COPHWh8sv4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DDEAFEA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDEAFEA>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDEAFEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

