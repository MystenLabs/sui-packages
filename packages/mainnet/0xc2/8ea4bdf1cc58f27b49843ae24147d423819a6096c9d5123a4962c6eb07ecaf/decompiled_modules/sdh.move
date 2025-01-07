module 0xc28ea4bdf1cc58f27b49843ae24147d423819a6096c9d5123a4962c6eb07ecaf::sdh {
    struct SDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SDH>(arg0, 6740678545936611035, b"Shadow whisperer", b"SDH", b"The creator", b"https://images.hop.ag/ipfs/QmacoJfbPVBmt84GjFecWjrAqovBvj5JAReYzzdwtDNmBe", 0x1::string::utf8(b"https://x.com/ShadowWhis01"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

