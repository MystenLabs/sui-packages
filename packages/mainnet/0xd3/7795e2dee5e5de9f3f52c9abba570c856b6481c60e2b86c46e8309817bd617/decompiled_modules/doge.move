module 0xd37795e2dee5e5de9f3f52c9abba570c856b6481c60e2b86c46e8309817bd617::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"doge", x"446f6765636f696e2069736e2774206a7573742061206d656d65e280946974e280997320612073796d626f6c206f662066756e2c2067656e65726f736974792c20616e642066696e616e6369616c20696e636c7573696f6e2e205768657468657220796f75277265207573696e6720697420666f722074697070696e672c2074726164696e672c206f72206a75737420686f6c64696e672c20444f47452069732061206c6567656e6461727920746f6b656e20696e207468652063727970746f20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWGinse11SPCUDcDKHPqqYngSXfuwpkxKqobscVUxzqF1")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

