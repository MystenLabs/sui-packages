module 0xdfeca88dbafa9f880c6193b1f4a400fc3b24e5a33b9e36057347bd9a6dd687b7::suikachu {
    struct SUIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKACHU>(arg0, 6, b"SUIKACHU", b"Suikachu Pokemon", x"5355494b41434855206973206120506f6b656d6f6e20696e737069726564205032452070726f6a656374206f6e2074686520537569202c20656e61626c696e6720706c617965727320746f20636f6c6c6563742c2074726164652c20616e6420626174746c6520756e6971756520506f6bc3a96d6f6e204e46547320696e206120706c617920746f206561726e2065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifuwq3qxahrpfv6rm7tqpgrytnxzivad2zxklby5esiludlhebn24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

