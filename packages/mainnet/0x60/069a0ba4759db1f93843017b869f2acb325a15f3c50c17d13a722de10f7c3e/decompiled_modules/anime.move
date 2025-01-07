module 0x60069a0ba4759db1f93843017b869f2acb325a15f3c50c17d13a722de10f7c3e::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ANIME>(arg0, 6511954721112299004, b"Anime", b"Anime", b"Anime is smart. Anime is life.", b"https://images.hop.ag/ipfs/QmNP4qbUt2rJQyBBk2A8htfKopo4gWnWE482LSHiSpbX43", 0x1::string::utf8(b"https://x.com/FranklinOnApe"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

