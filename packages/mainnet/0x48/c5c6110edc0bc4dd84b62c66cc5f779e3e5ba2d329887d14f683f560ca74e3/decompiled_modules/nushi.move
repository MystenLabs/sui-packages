module 0x48c5c6110edc0bc4dd84b62c66cc5f779e3e5ba2d329887d14f683f560ca74e3::nushi {
    struct NUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NUSHI>(arg0, 12750365814228217424, b"NUSHI", b"NUSHI", b"Nushi is the adorable yet ambitious memecoin launching on the Sui network. Represented by a lovable whale, Nushi's charm hides its insatiable hunger to \"devour\" market cap and make a splash in the Sui ocean. Check out our roadmap on our website", b"https://images.hop.ag/ipfs/QmTC9BYPxrVeudqEqcsi89L7rj9mP4uEgM9yb7WC1Dnzaw", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+s_IKKy0WD-UyZGI0"), arg1);
    }

    // decompiled from Move bytecode v6
}

