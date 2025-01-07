module 0x1f3bcc00d90b901d8ee5744471ef513babb68d055b96d3562bfc91c661661c7c::twromp {
    struct TWROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWROMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TWROMP>(arg0, 2218376183980466307, b"TWROMP", b"TWROMP", b"Bwroke? Don't be Dwomp. Get sum $TWROMP and join the bull run wave made by Trump!", b"https://images.hop.ag/ipfs/QmWYzj3NTHZggAnf5ckuVs6XmKfz6gw7VkM9iWEXwETupM", 0x1::string::utf8(b"https://x.com/TWROMP"), 0x1::string::utf8(b"https://twromp.xyz/"), 0x1::string::utf8(b"https://t.me/TwrompSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

