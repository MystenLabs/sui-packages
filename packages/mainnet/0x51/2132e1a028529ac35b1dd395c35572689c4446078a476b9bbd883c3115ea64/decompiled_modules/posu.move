module 0x512132e1a028529ac35b1dd395c35572689c4446078a476b9bbd883c3115ea64::posu {
    struct POSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSU>(arg0, 6, b"POSU", b"Poke SUI", b"Pokemon on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidexjx6oxrt6g6kx67ppc2ddyduqhb7ewjwj77etefptyam7ilgzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

