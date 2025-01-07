module 0xc8cfbbec2b9afd15bd659ec284ebafa90b465909e49041ccb9133d85df9b30ca::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MAD>(arg0, 6228697492767886291, b"MadLeen", b"MAD", b"Madleen is a revolutionary cryptocurrency designed to empower the gaming community, created by pro gamers for pro gamers. This digital token bridges the world of gaming and blockchain, offering players a unique way to earn, trade, and invest in a coin that celebrates skill, dedication, and esports culture. With Madleen, gamers can unlock rewards, exclusive content, and participate in competitive tournaments, all while contributing to the growth of the gaming ecosystem. Join the Madleen movement and level up your crypto game!", b"https://images.hop.ag/ipfs/QmUVKd7ruLvMLPTHcqT9ERu2D4vJC9dMdD1UrQqAz1FodX", 0x1::string::utf8(b"https://x.com/madleen_nft?t=opEw4lJjV6pDSM23eSv3sQ&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

