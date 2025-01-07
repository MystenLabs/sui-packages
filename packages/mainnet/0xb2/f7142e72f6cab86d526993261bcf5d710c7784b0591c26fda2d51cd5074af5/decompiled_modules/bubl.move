module 0xb2f7142e72f6cab86d526993261bcf5d710c7784b0591c26fda2d51cd5074af5::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUBL>(arg0, 417433856489033112, b"Bubl Sui", b"BUBL", x"627562626c65732061726520657665727977686572652077617465722069732c20616e6420537569206973206e6f20657863657074696f6e2e20546865792070756d702c20666c6f61742c20616e6420626f696c20e2809420746865792772652066756e2e205375692069732077617465722c207761746572206e65656473204255424c73", b"https://images.hop.ag/ipfs/QmXmqcu3onjriW626Avx7Tqn528iyMzuNNPZdtA8onJ3Cd", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com/"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

