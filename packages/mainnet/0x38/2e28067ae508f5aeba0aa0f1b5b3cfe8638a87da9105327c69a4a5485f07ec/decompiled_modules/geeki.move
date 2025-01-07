module 0x382e28067ae508f5aeba0aa0f1b5b3cfe8638a87da9105327c69a4a5485f07ec::geeki {
    struct GEEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEEKI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GEEKI>(arg0, 10674108796833379902, b"Geeki", b"Geeki", b"Gecko Sui Coin are Goals driven by Community", b"https://images.hop.ag/ipfs/QmahWDhQDpuY6jigcTkxaw6pdFuvVcAizU1TKqDNEUjrcK", 0x1::string::utf8(b"https://x.com/GekkiCoin?t=QSBlMiWe0rx6kwsuIZhypQ&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

