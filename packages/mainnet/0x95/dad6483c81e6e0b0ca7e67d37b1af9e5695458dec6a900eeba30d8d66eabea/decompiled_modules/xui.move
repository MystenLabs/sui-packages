module 0x95dad6483c81e6e0b0ca7e67d37b1af9e5695458dec6a900eeba30d8d66eabea::xui {
    struct XUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<XUI>(arg0, 14106645397183393829, b"XUI", b"XUI", x"d09fd180d0bed181d182d0be20d185d183d0b92e20d09ad180d0b5d0bfd0bad0b8d0b9", b"https://images.hop.ag/ipfs/QmSmFuxC6dnR7fT9R7rW5EjRuC8nb8smCGTPJeMfb81MGf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

