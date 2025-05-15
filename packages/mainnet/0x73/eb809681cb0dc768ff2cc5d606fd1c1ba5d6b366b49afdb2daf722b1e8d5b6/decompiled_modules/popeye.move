module 0x73eb809681cb0dc768ff2cc5d606fd1c1ba5d6b366b49afdb2daf722b1e8d5b6::popeye {
    struct POPEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYE>(arg0, 6, b"POPEYE", b"SUILORMAN", b"POPEYE THE SUILORMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiac7dnj2izovn46pqkmcmvxyv7y5qmt5mbs6ag6ndssuzcji3obd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPEYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

