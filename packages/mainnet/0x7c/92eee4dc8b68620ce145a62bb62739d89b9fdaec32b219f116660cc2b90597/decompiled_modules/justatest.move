module 0x7c92eee4dc8b68620ce145a62bb62739d89b9fdaec32b219f116660cc2b90597::justatest {
    struct JUSTATEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTATEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<JUSTATEST>(arg0, 8504156229073114135, b"just a test", b"justatest", b"just a test", b"https://images.hop.ag/ipfs/QmQ712JCzbpPs65Z1RdzWkDJ5UgsHnjBZpXwjypxysJwgG", 0x1::string::utf8(b"https://x.com/"), 0x1::string::utf8(b"https://website.com"), 0x1::string::utf8(b"https://t.me/"), arg1);
    }

    // decompiled from Move bytecode v6
}

