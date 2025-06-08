module 0xfc7b502837d599bc6f8ef926bb342c33853d50c6768f2e85b0fabaf98eb73fae::chatbtc {
    struct CHATBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATBTC>(arg0, 6, b"CHATBTC", b"CHATBTC AI", b"An artificial intelligence built to revolutionize the way traders navigate the crypto markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifakww3srss57eque7tpmht3xisjcbxjrj7wwic6yrcu4ranlp5oi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHATBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

