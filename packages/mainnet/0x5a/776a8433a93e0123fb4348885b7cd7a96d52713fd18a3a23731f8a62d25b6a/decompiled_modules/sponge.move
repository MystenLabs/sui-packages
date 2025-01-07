module 0x5a776a8433a93e0123fb4348885b7cd7a96d52713fd18a3a23731f8a62d25b6a::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SPONGE>(arg0, 10937217306374363052, b"SPONGEBOB ON SUI", b"SPONGE", b"Since SpongeBob SquarePants arrived at Hop.fun, the digital playground burst into even more color and laughter. With his bright yellow, spongey body, big blue eyes, and infectious enthusiasm, he quickly became the heart of every adventure. Always ready to lend a hand, SpongeBob dove into Hop.fun's vibrant world, exploring new games, meeting quirky characters, and, of course, spreading his signature positivity. Whether he's flipping virtual Krabby Patties or helping friends in underwater challenges, SpongeBob brings endless fun to everyone in this exciting, imaginative universe!", b"https://images.hop.ag/ipfs/QmZabKE1XWtdPoyM3TAQfoZ5U8vsgcs147gHM84kF5rsmC", 0x1::string::utf8(b"https://x.com/sui_sponge"), 0x1::string::utf8(b"https://spongebobb.fun/"), 0x1::string::utf8(b"https://t.me/sponge_portal"), arg1);
    }

    // decompiled from Move bytecode v6
}

