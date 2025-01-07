module 0x6a6cc1dc2603643f5b08775ed9af847e8954a1b692a9df69ca1c4077f9040fa5::snorkel {
    struct SNORKEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORKEL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SNORKEL>(arg0, 8469328016233023069, b"SNORKEL", b"SNORKEL", b"The Snorkel stays on.", b"https://images.hop.ag/ipfs/QmaYfbnre5RgPrGbBpreDrMzdYjubHw9dzxnLDG3xXDSEd", 0x1::string::utf8(b"https://x.com/SnorkelSUI"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+EJ44T3f8XRJkNjY5"), arg1);
    }

    // decompiled from Move bytecode v6
}

