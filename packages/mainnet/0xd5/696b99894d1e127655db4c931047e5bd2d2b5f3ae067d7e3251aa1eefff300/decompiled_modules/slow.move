module 0xd5696b99894d1e127655db4c931047e5bd2d2b5f3ae067d7e3251aa1eefff300::slow {
    struct SLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOW>(arg0, 6, b"SLOW", b"Suillow", x"54686520656c6567616e742062697264206f66205355492020666173742c20666561726c6573732c20616e6420666c79696e6720746f2074686520746f702e20496e737069726564206279205377656c6c6f772c2074686520686967682d666c79696e6720506f6bc3a96d6f6e206275696c7420666f7220676c6f72792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwbamzxijog7z7lqkxpobtx226sx7ch7kcuz3olhmpdqym374w54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

