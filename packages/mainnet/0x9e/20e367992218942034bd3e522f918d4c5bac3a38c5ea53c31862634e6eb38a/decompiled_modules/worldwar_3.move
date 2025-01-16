module 0x9e20e367992218942034bd3e522f918d4c5bac3a38c5ea53c31862634e6eb38a::worldwar_3 {
    struct WORLDWAR_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORLDWAR_3, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WORLDWAR_3>(arg0, 10706816125601593036, b"World War 3 Token", b"WorldWar3", b"World War 3 Token is the world's 1st F.O.meme. A fomeme is a FUTURE OUTCOME MEME. It's life is based on events from the future that influence the probabilities of the meme itself. By bringing in a new advancement and revolution to the meme culture, World War 3 Token takes the stage to capture the pioneering crown of a new generation of cryptocurrency. In a world that can cause chaos effortlessly due to it's fallen state, the idea of a doomsday world war always seems to knock on the door at humankind's attention. World War 3 Token takes grasp of the nature of Earth and humankind and tokenizes it into a speculation market for a coming world war. World War 3 Token is alive and not a dead meme. World War 3 Token is the new and original F.O.meme. This is not a get rich quick fix, it's a HODL token. You make your money by being the first to capitalize on what you think will happen before others begin to believe in what you've already known. This mechanism depends on uncontrollable future events. When news corporations, viral hype, and social rumors start inciting the media about WAR---you as a holder will already have the green moon in your possession! World War 3 Token! Buy the rumor, buy the news. Sell the rumor, sell the news! Maybe all those AI agents will all fuck around and find out that World War 3 Token is the #1 project! AGAIN, this is not a shit coin. Serious project. And you should also have a long term vision if you understand the \"meme\". Get in early to this epic project. You're early AF. You're welcome.", b"https://images.hop.ag/ipfs/QmPGV2J81pLogmTjDeVHvHdNcFGSYFwpMoYjhuEjSgGqgh", 0x1::string::utf8(b"https://x.com/WorldWar3tkn"), 0x1::string::utf8(b"https://www.worldwar3token.net"), 0x1::string::utf8(b"https://t.me/worldwar3network"), arg1);
    }

    // decompiled from Move bytecode v6
}

