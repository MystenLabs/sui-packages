module 0xddb4d68666004b4d5bf4f5a23e49feb02bdf45af9f268a57b7cded494caed187::toge {
    struct TOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOGE>(arg0, 6, b"TOGE", b"TOGEPI", x"4d65657420546f676570692020544f47452c207468652061646f7261626c6520506f6bc3a96d6f6e207468656d6564206d656d6520636f696e206f6e2074686520737570657220666173742053756920626c6f636b636861696e21205468697320666169727920656767206272696e67732066756e2c206c75636b2c20616e64206368616f746963204d6574726f6e6f6d6520766962657320746f20796f75722063727970746f206a6f75726e65792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigkqjnnx2h4mv2c3e26g42bon34py2tj5clz5rd6ne3qwhstdjrty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

