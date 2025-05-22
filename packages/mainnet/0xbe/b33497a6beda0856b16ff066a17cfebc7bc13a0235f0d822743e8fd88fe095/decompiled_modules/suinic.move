module 0xbeb33497a6beda0856b16ff066a17cfebc7bc13a0235f0d822743e8fd88fe095::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic on Sui", b"GOTTA GO FAST ON THE FASTEST BLOCKCHAIN SUIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichex7pednkqm5szwdnws2qpnnbdqufhliycyxorqjcdcyx7glaje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINIC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

