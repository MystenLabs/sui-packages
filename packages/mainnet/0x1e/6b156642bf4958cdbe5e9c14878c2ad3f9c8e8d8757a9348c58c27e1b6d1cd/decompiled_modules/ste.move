module 0x1e6b156642bf4958cdbe5e9c14878c2ad3f9c8e8d8757a9348c58c27e1b6d1cd::ste {
    struct STE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STE>(arg0, 4, b"STE", b"Thunder Eagle", b"1 Quadrillion of Sui Thunderbird coins has been created and fair launched where 100% of the tokens and 1500 Sui coins have been provided as liquidity on FlowX finance. Everyday 5% of the Sui Thunder coins(TSC) will be burned by sending them to the burn wallet untill 45-50% of STC to be burnt. LP tokens will be burnt when 45-50% of STC has gone to the burn wallet from LP. TSC will be the only coins which will be withdrawing from LP during the process of burning tokens.  Blockchain is a trustless so trust no body check all the process on chain or those different Suiscan explorers and analytics tools.  As a community member please don't kill the project by gobbling up all the coins just buy max 1% of the tokens untill LP and 45-50% of TSC to be burnt for your own security.!!! Let's make Sui Thunderbird the the biggest meme tokens on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGBtOYTtVy3ZKSDuo3nMrB43hJEJw5Q6l6KQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STE>>(v1);
    }

    // decompiled from Move bytecode v6
}

