module 0x14ef5620b2ed25c2b96f30fef8f7182d5471bc563610a9f14561addc81dbca2::sx {
    struct SX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SX>(arg0, 9, b"SX", b"SecretX", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS5SbtxEYsLUKnDH1b22UDzV9BhzqYvLt7umCcbsrXk2c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

