module 0x9a187d16bf14fc10cc4b7db2764de6eeef16babfef3092a3cb1e72023c105be0::glaceon {
    struct GLACEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLACEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLACEON>(arg0, 6, b"Glaceon", b"Glaceon SUI", b"Dive into the depths of opportunity. The most beautiful Pokemon ever, a symbol of elegance, and wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmecva74ifsl6df7a3rwp2324vfn45rhoa77raibak4n6xzdgury")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLACEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLACEON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

