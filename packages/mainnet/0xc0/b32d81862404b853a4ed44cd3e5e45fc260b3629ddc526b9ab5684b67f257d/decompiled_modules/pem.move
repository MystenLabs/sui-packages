module 0xc0b32d81862404b853a4ed44cd3e5e45fc260b3629ddc526b9ab5684b67f257d::pem {
    struct PEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PEM>(arg0, 3712331549995042304, b"Peme King", b"PEM", b"Pirate King is a bold and playful memecoin embodying high-seas adventure. Featuring a crowned pirate skull on a golden coin, it captures the allure of buried treasure and maritime charm. A perfect find for pirate and crypto fans alike!", b"https://images.hop.ag/ipfs/QmZdHYScqbKp5w6r4jWGHF3yghJnzfqjg2oV73m76mPnV1", 0x1::string::utf8(b"https://x.com/pemepirateking"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

