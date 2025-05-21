module 0xec588a0cbb8633e2308dd16bc1eb60528388ecd4692b62a1daed115138fca043::suino {
    struct SUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO>(arg0, 6, b"SUINO", b"Articsuino", x"4c6567656e64617279206269726420506f6bc3a96d6f6e2074686174206973207361696420746f2061707065617220746f20646f6f6d656420646567656e732077686f20617265206c6f737420696e2074686520636f6c6420696379207472656e636865732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibrmy2bgi4kuleot4fucdviimhy7hkbl24z47nsi7lps5epm6fnji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

