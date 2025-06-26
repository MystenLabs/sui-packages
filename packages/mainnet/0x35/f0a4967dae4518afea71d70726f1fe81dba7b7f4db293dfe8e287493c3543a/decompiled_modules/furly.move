module 0x35f0a4967dae4518afea71d70726f1fe81dba7b7f4db293dfe8e287493c3543a::furly {
    struct FURLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURLY>(arg0, 6, b"Furly", b"WDFurly", x"462a256b65640a55700a5223744072640a4c75726b696e67200a596f750a0a546869732069732061206d656d6520616e642061206d6f76656d656e7420616761696e73742070656f706c6520747279696e6720746f3a2074616b65206f7665722070726f6a656374732c206a757374206265696e67206c616d6520746f206465767320616e642061646d696e732e20616c776179732077616e7420746f206265206c65616420616e6420696e636861726765206f6620736f6d656f6e6520656c7365277320776f726b210a4e6f20656d6f74696f6e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagdxbf7qxbp3o7lc4vh7fx77cxb4fdxnnblka5q7jri7scqp66de")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FURLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

