module 0xd2504806554c9d0125ace34c46596de02615c1477cbda62c41f3203edfba11e0::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SM>(arg0, 2220768173970451281, b"SIMO", b"SM", b"My own work", b"https://images.hop.ag/ipfs/QmNURU8krS2HTCHBNjwjwFgcr71Kjr8LvFicCsHrpjw6Wx", 0x1::string::utf8(b"https://x.com/ictforex0"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/Hosammahdy_eth"), arg1);
    }

    // decompiled from Move bytecode v6
}

