module 0x9b9c0e26a8ace7edb8fce14acd81507c507c677a400cfb9cc9a0ca4a8432a97a::loopy_sui {
    struct LOOPY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY_SUI>(arg0, 6, b"LOOPY", b"LOOPY", b"The most adorable cult to ever invade SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOPY_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOPY_SUI>>(0x2::coin::mint<LOOPY_SUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOOPY_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

