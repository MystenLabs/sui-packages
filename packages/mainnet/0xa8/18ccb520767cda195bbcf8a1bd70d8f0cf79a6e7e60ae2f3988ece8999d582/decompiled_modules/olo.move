module 0xa818ccb520767cda195bbcf8a1bd70d8f0cf79a6e7e60ae2f3988ece8999d582::olo {
    struct OLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLO>(arg0, 6, b"OLO", b"Olo The Croc", x"426f726e20696e20746865207377616d702e204275696c7420666f72207468652053756920636f6d6d756e6974792e0a0a244f4c4f20706f7765727320746865207661756c742c20746865206d61726b6574706c6163652c20616e6420746865206675747572652e0a0a5374617920536e6170707921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie6c7qppi7lfen26wkflictrhjcskdgneg6x5cnvsb4m76h5j7hyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

