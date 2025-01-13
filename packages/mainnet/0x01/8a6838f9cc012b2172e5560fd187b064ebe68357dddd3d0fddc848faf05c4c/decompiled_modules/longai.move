module 0x18a6838f9cc012b2172e5560fd187b064ebe68357dddd3d0fddc848faf05c4c::longai {
    struct LONGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONGAI>(arg0, 9, b"LONGAI", b"Longevity AI", x"446563656e7472616c697a6564204c6f6e676576697479205265736561726368204149204167656e740d0a0d0a41204465536369204149206167656e742061696d696e6720746f20696d70726f766520427279616e204a6f686e736f6e7320426c75657072696e742050726f746f636f6c20627920726576696577696e67206576657279207265736561726368207061706572207075626c6973686564206f6e2062696f5278697620616e64206d6564527869762e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaNrGEBvGY8kqAPdjT12JUeP2uA8EyMFcgwpq2yYmGaj8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LONGAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONGAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

