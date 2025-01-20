module 0xd0e748ce03190a2a274c2b2b74404d379de572983b933da68af8db93392a4d62::trumpfam {
    struct TRUMPFAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPFAM>(arg0, 9, b"TRUMPFAM", b"Official Family Coin", b"A family that takes a step into the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ18up9MGXhCCTQ4dhjJ3AXnzdrF1cEUdj9KcNLxvpX1W")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPFAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPFAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

