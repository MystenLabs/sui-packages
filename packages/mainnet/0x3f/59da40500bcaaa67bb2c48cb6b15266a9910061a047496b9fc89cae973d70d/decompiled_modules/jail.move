module 0x3f59da40500bcaaa67bb2c48cb6b15266a9910061a047496b9fc89cae973d70d::jail {
    struct JAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAIL>(arg0, 6, b"Jail", b"adeniyi jailed", b"adeniyi  in jail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcep7h6vevh3c5ouuor75ub4236kxanf3lekp24omdqnoyrsz6jm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

