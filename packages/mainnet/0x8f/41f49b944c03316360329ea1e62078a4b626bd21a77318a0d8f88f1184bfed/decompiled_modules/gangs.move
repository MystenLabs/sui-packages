module 0x8f41f49b944c03316360329ea1e62078a4b626bd21a77318a0d8f88f1184bfed::gangs {
    struct GANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGS>(arg0, 6, b"GANGS", b"Sui Gangs", b"Sui Gangster in one Place. RELAUNCH on Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebywdoqh547hlkbuhep2rwgef5i755ygrvx4gten37znl2naapju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GANGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

