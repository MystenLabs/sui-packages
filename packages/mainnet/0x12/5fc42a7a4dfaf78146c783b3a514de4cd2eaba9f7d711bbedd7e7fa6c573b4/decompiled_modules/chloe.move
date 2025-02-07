module 0x125fc42a7a4dfaf78146c783b3a514de4cd2eaba9f7d711bbedd7e7fa6c573b4::chloe {
    struct CHLOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLOE>(arg0, 9, b"CHLOE", b"SIDE EYEING CHLOE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUu1g15acZm6m2ifGs3KsgHFe7cjjBvWX7J5d5kcfcoGF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHLOE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHLOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLOE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

