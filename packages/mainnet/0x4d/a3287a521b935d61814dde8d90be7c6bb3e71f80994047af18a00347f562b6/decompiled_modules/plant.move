module 0x4da3287a521b935d61814dde8d90be7c6bb3e71f80994047af18a00347f562b6::plant {
    struct PLANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PLANT>(arg0, 9517159180195122138, b"plant", b"plant", b"plant forest coin", b"https://images.hop.ag/ipfs/QmaQvACxLBapc1bzGnqfFVWf73SqajxkWnT46ZF2V7Xp4Y", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

