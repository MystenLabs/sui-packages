module 0xb5d0ac0dc6108228b7024d7943c06d21dae8eacf0199063dbf85e82742d8b7ee::catana {
    struct CATANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATANA>(arg0, 9, b"CATANA", b"Sui Catana", b"Catana forged by samurai masters, has risen as a legendary warrior, wielding unmatched skill and fearless courage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmRyRQYLJvZRztocmqqGESYMFmju2BBDU7RJxF1zcM9n4J?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATANA>(&mut v2, 150000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

