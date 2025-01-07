module 0x3f8d52acaf58a2c6f1bc5b7a2a01abe45440dfdce6be10f60ea9dbce1615cc41::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SQUIRT>(arg0, 12397045689697899608, b"Squirt", b"Squirt", b"A playful, pint size water character, emphasizing the \"Sui\" (water in Japanese) theme. This character is a cheerful, animated squirt of water with expressive, fun eyes and a cheeky smile, making waves in the crypto community.", b"https://images.hop.ag/ipfs/Qmb6Z6TAwCaj3iPaQDKpPtB4uUxnwd2f6DwWKkdPZSTNfK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

