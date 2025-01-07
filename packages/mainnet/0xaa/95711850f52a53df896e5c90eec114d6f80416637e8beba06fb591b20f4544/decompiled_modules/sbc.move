module 0xaa95711850f52a53df896e5c90eec114d6f80416637e8beba06fb591b20f4544::sbc {
    struct SBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBC>(arg0, 4, b"SBC", b"Sassy Bird Coin", b"Sassy Bird Coin is a community driven native token on Sui blockchain and fair launch token where 40% of the tokens have been sent to the DEAD wallet.!! Proof can be seen on Sassy's contract address. An other 40% of the tokens and 2000 Sui coins have been provided as liquidity on DEXes built on Sui.  LP tokens has been burnt and sent to the DEAD Wallet.Proof of burned LP tokens will be published on Sassy's X(Twitter)account. The other 20% of the tokens are going to send to the DEAD wallet for next 7 days by sending 2-3% of them everyday untill we burn them all. So you as a member of the Sassy community please let's give the other community members the chance to be part of the biggest meme tokens on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/93b99b17-a5e8-43ed-8169-18b593ff73e6/dgc1zmi-9f5895f7-80c3-42b1-a5cf-cf9800015043.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzkzYjk5YjE3LWE1ZTgtNDNlZC04MTY5LTE4YjU5M2ZmNzNlNlwvZGdjMXptaS05ZjU4OTVmNy04MGMzLTQyYjEtYTVjZi1jZjk4MDAwMTUwNDMucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.ODL5ewk1qfrk0azaqkBSIPxt-tzhnPQ5NbkKiv5F4bs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

