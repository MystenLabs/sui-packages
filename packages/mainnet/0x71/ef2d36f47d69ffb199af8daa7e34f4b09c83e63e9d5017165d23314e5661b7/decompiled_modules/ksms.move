module 0x71ef2d36f47d69ffb199af8daa7e34f4b09c83e63e9d5017165d23314e5661b7::ksms {
    struct KSMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSMS>(arg0, 6, b"Ksms", b"KissMe SUI", b"Welcome {first} to the exciting world of SUI! Kiss SUI now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibveclxjzz4st6nfgfmhgvs6ogudcuwq4r5lzb4dplvxwgoubhp6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KSMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

