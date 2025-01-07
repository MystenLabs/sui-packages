module 0x5ac5124623f41f11f5776a207d9bdeb74531ffc7b3c9199ea177260f7cf4f814::tcs {
    struct TCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCS>(arg0, 9, b"TCS", b"Trident Clash Sui", b"Token Name: Trident Clash Sui (TCS) Blockchain: Sui Network Symbol: TCS Total Supply: [Specify the total supply if determined]  Description: Trident Clash Sui is a revolutionary meme coin designed to merge the mythical world of Poseidon with the innovative capabilities of blockchain technology. Built on the Sui Network, TCS aims to create a vibrant community of ocean enthusiasts and crypto investors who are ready to ride the waves of the meme coin phenomenon.  Key Features:  Unique Theme: The token embodies the spirit of the ocean, celebrating the legendary Poseidon and the dynamic battles of the deep sea, making it an engaging and relatable project for the crypto community. Community-Driven: TCS encourages participation and interaction among its holders, fostering a collaborative environment where everyone can contribute to the growth of the project. Rewards for Liquidity Providers: By providing liquidity, holders can earn transaction fees, promoting sustainability and engagement within the community. Fun and Engaging: The meme aspect of the project encourages creativity and fun, making it more than just an investment, but a journey into the world of crypto memes. Join the Trident Clash Sui community and make a splash in the exciting ocean of cryptocurrencies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/qpLaPyp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TCS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

