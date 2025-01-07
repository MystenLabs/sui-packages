module 0x16e7860d34d0087907378cf6745b1f6eebcf4a4b1dea975a17fbad81c1ed257::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"IMG", b"IMG Coin", b"flourishing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOPY>>(0x2::coin::mint<LOOPY>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOOPY>>(v2);
    }

    // decompiled from Move bytecode v6
}

