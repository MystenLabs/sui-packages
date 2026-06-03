module 0x6838f3c08e9fa51ceb34b4e59537efb7957b4dc06c0b1aa562c47d2e2dd7606f::jail {
    struct JAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAIL>(arg0, 6, b"Jail", b"big day", b"big day coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcep7h6vevh3c5ouuor75ub4236kxanf3lekp24omdqnoyrsz6jm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

