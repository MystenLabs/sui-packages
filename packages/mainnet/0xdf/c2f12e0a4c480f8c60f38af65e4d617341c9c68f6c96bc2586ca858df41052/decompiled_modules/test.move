module 0xdfc2f12e0a4c480f8c60f38af65e4d617341c9c68f6c96bc2586ca858df41052::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TEST>(arg0, 1911285236010226824, b"test", b"test", b"test", b"https://images.hop.ag/ipfs/QmPeGdVtJsaYpDkBdkSwJBA5NvqXrvRipto5AiBtqLqjPr", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

