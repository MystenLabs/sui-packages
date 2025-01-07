module 0x89e7415885f6cdabb738b79c7e3704eb6d8ff268556c4d08fdeeafa95d21b80e::lsui {
    struct LSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LSUI>(arg0, 4661931717529949933, b"Lussy", b"LSUI", b"Let's make some fun, a meme token that have vision to be the most iconic meme on SUI. Grab some, hold some, make profit together with us.", b"https://images.hop.ag/ipfs/QmSJb4mY7HTn7Lfs36S2z2oqFSJ5V1F7PmRuk3A7Vcb2MC", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://t.me/pocketfi_bot/bigpump?startapp=rinyarny_3011-eyJjb2luSWQiOiIxNzY1NyJ9"), 0x1::string::utf8(b"https://t.me/xtonporn"), arg1);
    }

    // decompiled from Move bytecode v6
}

