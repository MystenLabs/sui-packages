module 0x4840b9cfa6b966355a976575ab4112ee87a7eb138cdcab9cd93b32950933e5ac::coil {
    struct COIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIL>(arg0, 6, b"COIL", b"Slicky The Coil", x"4d65657420536c69636b792c20746865206f696c6965737420636f696e20696e207468652067616d652e0a426f726e2066726f6d2074686520646570746873206f6620646567656e206d696e696e67207269677320616e6420677265617379206d656d65636f696e732e204f6e652064726f70206f66206f696c2c20616e6420796f757220706f7274666f6c696f20676f65732076726f6f6d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpveuqmkqiiithsgxxzy2wydabjh46i5n2ulus6axffpekh6kqpi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

