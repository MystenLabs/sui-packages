module 0x40cc143ef0605b6401bcf43e7d348c2f7b9bb9b293cfb2c6a1afcfb554fe60e7::cuy {
    struct CUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CUY>(arg0, 791202466107343539, b"SUICUY", b"CUY", b"Suicuy is Sui's First Cavy Meme Coin", b"https://images.hop.ag/ipfs/QmNgX33drBaZSC3cUpWpva6VMx9ctTYrgZsFexxwjFKzGZ", 0x1::string::utf8(b"https://x.com/SUICUY"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

