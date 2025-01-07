module 0x9de760fcf2c53b9ee2be261998e8489e2212aa3d20dd91498d1e8fe928519a39::oda {
    struct ODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ODA>(arg0, 17645545776886141683, b"Oda Senpai", b"ODA", b"You want my Token! You can have it! Look for him! I have the best Coin in the World hidden somewhere ...  Do you want to become king of crypto and crack the millions? What are you waiting for? Invested!!", b"https://images.hop.ag/ipfs/QmayEZDaZNR5gWZRoBBndJBntXNWUuJVGkLEmyunmyKY6G", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

