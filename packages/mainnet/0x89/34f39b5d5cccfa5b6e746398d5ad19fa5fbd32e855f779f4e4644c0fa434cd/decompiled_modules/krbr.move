module 0x8934f39b5d5cccfa5b6e746398d5ad19fa5fbd32e855f779f4e4644c0fa434cd::krbr {
    struct KRBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRBR>(arg0, 9, b"KRBR", b"KURWA BOBR", b"first Kurva Bobr on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRBR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRBR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

