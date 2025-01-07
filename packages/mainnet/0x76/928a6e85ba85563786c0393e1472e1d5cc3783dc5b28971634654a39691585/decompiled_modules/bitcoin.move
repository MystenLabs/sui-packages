module 0x76928a6e85ba85563786c0393e1472e1d5cc3783dc5b28971634654a39691585::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"HarryPotterObamaSonic10Inu", b"HarryPotterObamaSonic10Inu (Ticker: BITCOIN) is a endgame of crypto-assets (0 Tax). BITCOIN incentivizes the creation of novel and entertaining meme content. With ownership renounced and Liquidity locked, our robust growing community has taken the lead; we have successfully completed a full audit, an NFT collection, and are exploring partnerships with other tokens in the space, a one-of-a -kind website, and one-of-a-kind merchandise and ecommerce site in the works based on the legendary meme that inspired BITCOIN's creation. Our goal is to create an ecosystem for active community members to meet, collaborate, and share our rich lore (the archive of our token's storied history) with the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x72e4f9f808c49a2a61de9c5896298920dc4eeea9.png?size=xl&key=f1dbbb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BITCOIN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

