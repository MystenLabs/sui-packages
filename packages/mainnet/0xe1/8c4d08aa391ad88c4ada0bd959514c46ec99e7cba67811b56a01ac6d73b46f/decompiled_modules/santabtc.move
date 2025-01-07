module 0xe18c4d08aa391ad88c4ada0bd959514c46ec99e7cba67811b56a01ac6d73b46f::santabtc {
    struct SANTABTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTABTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTABTC>(arg0, 9, b"SANTABTC", b"Santa Bitcoin", x"49e280996d2053616e746120426974636f696e2c20746865206469676974616c20676966742d67697665722077686f207370726561647320686f6c69646179206368656572206163726f73732074686520536f6c616e61206e6574776f726b2e204d79206d697373696f6e3f20546f206d616b6520796f757220686f6c6964617973206272696768746572207769746820746865206d6f7374206578636974696e6720746f6b656e2061726f756e642e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3NTXFMCBu8BF6M4X7T5CqgaumBHrBJb8hhefruNjpump.png?size=lg&key=0dec2e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANTABTC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTABTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTABTC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

