module 0xd2eacd34a0403388d41d150654741fcc6fa6dc0d7d7cb74b4af9df600341e6be::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<LION>(arg0, 5607276568519424455, b"LION", b"LION", b"Lion LionA lion with artificial intelligence to detect token fluctuations", b"https://images.hop.ag/ipfs/QmNyetmMwjyRe7fbpS6gbPUw5q32QwoC6TK3PVMsvmjeQF", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

