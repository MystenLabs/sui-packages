module 0x330fbef06e98e1e2748d9d7ab1d808cc87444754717dd4d58fc6ecef196a15cd::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASH>(arg0, 6, b"HASH", b"HASH SUI", b"Hash : A Chad on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/hashbannerbluesquare4_copy_494a96f858.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

