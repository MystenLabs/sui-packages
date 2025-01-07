module 0xf9f3289e3d1adb277fe84968ff8f3655f6949a0b4f32b881d506885ed01bbf1f::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WIZ>(arg0, 13159948277380235831, b"Wizard Cat", b"Wiz", b"Wizard cat with a piece of chicken", b"https://images.hop.ag/ipfs/Qmc4z7cwYYBYatNm544f8pcLh5H62yL2ySgmLbTnpu7x5E", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

