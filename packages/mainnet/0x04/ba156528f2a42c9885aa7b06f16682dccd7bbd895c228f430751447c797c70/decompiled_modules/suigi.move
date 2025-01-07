module 0x4ba156528f2a42c9885aa7b06f16682dccd7bbd895c228f430751447c797c70::suigi {
    struct SUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIGI>(arg0, 14796128900755369439, b"Suigi Mangione", b"Suigi", b"Suigi mungione is a Sui maxi with the conviction to stand for sui no matter the cost, he is selfless toward the greater good of sui", b"https://images.hop.ag/ipfs/QmWgL7R8fNGTMxkBEGPpwWG2SthVPoD9xQ9G2hka4FPgDf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

