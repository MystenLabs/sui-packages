module 0x5dba83f4668f4dafa300b02053d0590dcfc2ea23aba0575aa5e6e68e66d0ccf8::TESTCOIND {
    struct TESTCOIND has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIND>, arg1: 0x2::coin::Coin<TESTCOIND>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTCOIND>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIND>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIND>>(0x2::coin::mint<TESTCOIND>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTCOIND>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOIND>>(arg0);
    }

    fun init(arg0: TESTCOIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIND>(arg0, 9, b"TESTCOIND", b"Test D", b"This is only a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXkVde4AVDnwcNAupToHuCmx6dEbf2WwNqMM9f4VmhV2k")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

