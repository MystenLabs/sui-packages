module 0xae110e1dab0aef085515ccba2de6d0fed533fe89243daf88f462a8ec245b092b::test_2 {
    struct TEST_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_2, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TEST_2>(arg0, 13765208991386533777, b"test 2", b"test 2", b"123 123 123 123", b"https://images.hop.ag/ipfs/QmT1Wxw2tkXztaSDagc7RyfKbVMnc4SN4vNfiSzv5JWaeP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

