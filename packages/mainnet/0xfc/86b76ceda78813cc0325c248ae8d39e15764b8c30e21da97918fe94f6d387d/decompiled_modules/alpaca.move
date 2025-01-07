module 0xfc86b76ceda78813cc0325c248ae8d39e15764b8c30e21da97918fe94f6d387d::alpaca {
    struct ALPACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPACA>(arg0, 9, b"ALPACA", b"Alpaca Sui", x"414c5041434120697320696e7370697265642062792074686520616c706163612c20426974636f696ee2809973206d6173636f74202e204a757374206c61756e636865642e2032306b2e20476f6f64206272616e64696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.alpaca-token.com/wp-content/uploads/2024/10/Tokenomics.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALPACA>(&mut v2, 336000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPACA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

