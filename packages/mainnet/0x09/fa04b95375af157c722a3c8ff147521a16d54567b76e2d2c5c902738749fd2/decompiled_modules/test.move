module 0x9fa04b95375af157c722a3c8ff147521a16d54567b76e2d2c5c902738749fd2::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TEST>(arg0, 14849669812469461993, b"TEST", b"TEST", b"TEST", b"https://images.hop.ag/ipfs/QmXf4p3tUU77Nccsbi1eYddgDKvnSHeGpLwyzcxCUG2ALv", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

