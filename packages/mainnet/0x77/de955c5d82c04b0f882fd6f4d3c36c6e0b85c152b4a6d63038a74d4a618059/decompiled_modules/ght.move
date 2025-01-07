module 0x77de955c5d82c04b0f882fd6f4d3c36c6e0b85c152b4a6d63038a74d4a618059::ght {
    struct GHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHT>(arg0, 5, b"GHT", b"Gold Horse Token", b"Gold Horse Token on Sui blockchain is a fair launch Token 50% of the tokens and 100 Sui coins have been provided as liquidity on Aftermath DEX and the LP has been burnt by sent to the DEAD Wallet. The other 50% of the tokens has been divided into two equal parts: 25% of the tokens has been sent to the DEAD WALLET & the other 25% are going to send 2,5% of them to the DEAD Wallet on every Monday until ends. Trust no one check all these info on chain/ proof of all these info can be seen on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShdoeSmXCCso2BuOhIcueGni7gO5hcZQnCltwYsC26auWV551JM3j65rAKAbVREJTaUI0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GHT>(&mut v2, 7500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

