module 0x3a01e897dd0674acb5294b0988b10adc14e1fe6d8a4d7ef3c44b33ed2570532c::dontquit {
    struct DONTQUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTQUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTQUIT>(arg0, 6, b"DONTQUIT", b"DONT QUIT", b"DON'T QUIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqaxp7jzsz4nrwvt7ggnjl7nknzdh3grp7fohei7mrdbxh3cebrm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTQUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONTQUIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

