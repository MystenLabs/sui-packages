module 0x1c76217833cad0ceeac16ca522ba1820358c071b7b42d991abb10ae15c1c93ed::mrsui {
    struct MRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSUI>(arg0, 6, b"MRSUI", b"Mr SUI", x"53554920636861696ec2b473207065726665637420506f6b656d6f6e206d6173636f742026207469636b657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihq5jgs72gj4v5555iujuu6fswrojzydmgtbw7sdnxvwk5r3uhune")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MRSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

