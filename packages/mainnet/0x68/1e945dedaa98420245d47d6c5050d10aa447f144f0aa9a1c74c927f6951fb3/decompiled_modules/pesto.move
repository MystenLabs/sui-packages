module 0x681e945dedaa98420245d47d6c5050d10aa447f144f0aa9a1c74c927f6951fb3::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PESTO>(arg0, 6444926218305352272, b"Pesto", b"PESTO", b"Pesto Token celebrates the beloved viral penguin, Pesto, who captured hearts worldwide with his journey from fluffy chick to striking adult at Sea Life Melbourne Aquarium. As he transforms from fluffy chick to majestic adult, Pesto has become a symbol of growth, resilience, and the wonders of wildlife. Embrace the spirit of Pesto.", b"https://images.hop.ag/ipfs/QmX5NC9cW6KX8UC4g3a4p9YVQJZVGKCRJA7XTtN3s1awXc", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

