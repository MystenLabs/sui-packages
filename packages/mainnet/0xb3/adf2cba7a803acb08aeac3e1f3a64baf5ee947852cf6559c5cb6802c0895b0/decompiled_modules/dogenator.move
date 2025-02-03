module 0xb3adf2cba7a803acb08aeac3e1f3a64baf5ee947852cf6559c5cb6802c0895b0::dogenator {
    struct DOGENATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGENATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGENATOR>(arg0, 9, b"DOGENATOR", b"Dogenator", x"494c4c20424520424f524b210d0a0d0a5768656e206d656d6573206d65657420746865206675747572652020446f67656e61746f7220697320626f726e2e20546865207065726665637420667573696f6e206f6620746865206c6567656e6461727920446f676520616e64207468652069636f6e6963205465726d696e61746f722e204865206469646e74206a75737420636f6d6520746f206a6f6b652068652063616d6520746f20626f726b2e20412063796265726e65746963207368656c6c2c2061206d656d652d66696c6c65642068656172742c20616e6420616e20656e646c65737320737570706c79206f66207375636820776f772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmacVbcdLHwXAFBJMJ1SusK9EMmSDCVf5P2DkvNNkCCwUn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGENATOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGENATOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGENATOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

