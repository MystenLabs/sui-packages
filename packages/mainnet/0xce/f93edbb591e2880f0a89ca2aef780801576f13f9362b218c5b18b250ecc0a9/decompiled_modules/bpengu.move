module 0xcef93edbb591e2880f0a89ca2aef780801576f13f9362b218c5b18b250ecc0a9::bpengu {
    struct BPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPENGU>(arg0, 6, b"BPENGU", b"BABYPENGU", b"$BABYPENGUSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif35x6qdhnmx7vyf4d4wbbkniyzjsohbmkpf2july6nwzhs7giuim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BPENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

