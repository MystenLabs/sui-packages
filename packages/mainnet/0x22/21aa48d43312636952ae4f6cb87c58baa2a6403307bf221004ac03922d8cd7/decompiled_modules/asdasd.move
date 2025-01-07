module 0x2221aa48d43312636952ae4f6cb87c58baa2a6403307bf221004ac03922d8cd7::asdasd {
    struct ASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ASDASD>(arg0, 16909616994660333117, b"asdasd", b"asdasd", b"asdasd", b"https://images.hop.ag/ipfs/QmWHUntEF2Tb7HpWmzLr2uUT3RaxRaA1UAYPYnCYcJzXhA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

