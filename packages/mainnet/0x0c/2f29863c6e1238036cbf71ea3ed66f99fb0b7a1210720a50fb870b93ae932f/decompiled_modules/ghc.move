module 0xc2f29863c6e1238036cbf71ea3ed66f99fb0b7a1210720a50fb870b93ae932f::ghc {
    struct GHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHC>(arg0, 7, b"GHC", b"Gold Horse Coin", b"Gold Horse Coin on Sui blockchain is a fair launch Token 50% of the tokens and 100 Sui coins have been provided as liquidity on Aftermath DEX and the LP has been burnt by sent to the DEAD Wallet.   The other 50% of the tokens has been divided in the following: 25% of the tokens has been sent to the DEAD WALLET & the other 25% is held in the creator's wallet and we are going to send 2,5% of them to the DEAD Wallet every Monday until ends. Trust no one check all these info on chain/ proof of all these info can be seen on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShdoeSmXCCso2BuOhIcueGni7gO5hcZQnCltwYsC26auWV551JM3j65rAKAbVREJTaUI0&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GHC>(&mut v2, 9850000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHC>>(v1);
    }

    // decompiled from Move bytecode v6
}

