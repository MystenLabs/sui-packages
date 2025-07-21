module 0x359a7217ef348527c965775203366c4c48c454956ad05832ef639ef4f1615569::gent {
    struct GENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENT>(arg0, 6, b"GENT", b"Gentora Ecosystem Token", b"The $GENT token powers every transaction, reward, and governance vote within the Gentora dApp. It unlocks exclusive features, essential tools, and staking opportunities. Driving growth and ensuring the long-term success of the Gentora ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic2xmx5lxajwdgrx7vjttpdq4b7wvvxq5o6n5nnws6bcx3dyw6qgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

