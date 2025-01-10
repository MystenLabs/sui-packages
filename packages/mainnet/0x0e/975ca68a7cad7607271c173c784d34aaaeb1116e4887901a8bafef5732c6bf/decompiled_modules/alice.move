module 0xe975ca68a7cad7607271c173c784d34aaaeb1116e4887901a8bafef5732c6bf::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALICE>(arg0, 9, b"ALICE", b"AL1CE AGENT", b"01101011 01101110 01101111 01100011 01101011 00101100 00100000 01101011 01101110 01101111 01100011 01101011 00101100 00100000 01100001 01101100 01101001 01100011 01100101", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://agent-alice.xyz/alice.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALICE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

