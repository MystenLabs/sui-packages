module 0x8260c3b60d24207d7c69f19067ed19c7939c0efd0daff70b2d021f4162559cff::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 6, b"BITCOIN", b"HarryPotterObamaSonic10Inu", b"BITCOIN incentivizes the creation of novel and entertaining meme content. With ownership renounced and Liquidity locked, our robust growing community has taken the lead; we have successfully completed a full audit, an NFT collection, and are exploring partnerships with other tokens in the space, a one-of-a -kind website, and one-of-a-kind merchandise and ecommerce site in the works based on the legendary meme that inspired BITCOIN's creation. Our goal is to create an ecosystem for active community members to meet, collaborate, and share our rich lore (the archive of our token's storied history) with the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitcoin_09e8129548.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

