module 0xfe240f08e986f811bbd14b9584cc393c08990bde26fc1eaa0d8724fb814caef3::bwn {
    struct BWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BWN>(arg0, 1004983582609447712, b"Because why not", b"BWN", x"4c6574e28099732074727920746f67657468657220746865206e6577206d656d6520636f696e", b"https://images.hop.ag/ipfs/Qmc9bgJwvsUgLWxiQYfu9XYUktXeiCUr7943Xd2YD1wBX1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

