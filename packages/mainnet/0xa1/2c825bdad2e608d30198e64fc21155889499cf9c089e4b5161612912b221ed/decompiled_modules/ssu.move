module 0xa12c825bdad2e608d30198e64fc21155889499cf9c089e4b5161612912b221ed::ssu {
    struct SSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSU>(arg0, 4, b"SSU", b"Sui Shuidi coin", b"Shuidi means Water drop in Chinese and Shuidi coins are really fair launched coins where 50% of the minted Shuidi tokens has been destroyed and sent them to the burn wallet. The other 50% of the tokens and 500 Sui coins have been provided as a liquidity on FlowX Finance DEX. All Liquidity Pool tokens (LP tokens) are burned to the dead wallet.  A proof of a video clip showing burning LP tokens is published on Shuidi's X/Twitter  @ShuiToken  check out that clip the rest will be history. Go and check out the burn wallet for those LP tokens which are sent from creator's wallet. Liquidity will never be removed by any chance. This meme coin Shuidi will be the next 100-1000X on Sui network. The million dollar question will be why I'm donating my own 500 Sui coins=425 USD to provide liquidity for Shuidi ?  The answer is: I've been scammed so many times by heartless scammers and I want to show them that meme coins are not only to scam the people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR-tL1EbuheSK6tdtWCxs1d4ZNCl7VBAae8A&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSU>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

