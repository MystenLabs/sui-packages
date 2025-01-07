module 0xb53b0ada678c2b0e722ee96231cbd2c34e79829dafeca6bd84a4c460b6a8e275::elphnt {
    struct ELPHNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELPHNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELPHNT>(arg0, 6, b"ELPHNT", b"Suilephant", b"A Blue Elephant Casually Pleasuring Themself on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcB9C7uDJon9eeq4Wx1w3Lp7e9BWuvKfEFe2H2zMMHk37")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<ELPHNT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<ELPHNT>(11585133405102886347, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

