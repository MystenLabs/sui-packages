module 0x7f28272f4b67581653cfe9773d0d9da25472391434c07f3a40df6bbd00f21d::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPE>(arg0, 17394026010284591805, b"HOPE", b"$Hope", b"\"Success is a journey, not a destination. The only true failure occurs when you stop trying. Every setback is an opportunity to learn and grow; perseverance transforms challenges into stepping stones toward your goals. Embrace the process, keep pushing forward, and remember that determination fuels achievement.\"", b"https://images.hop.ag/ipfs/QmQnFg3kaRBrH77r4b959p8bwJGGHC94PEvRGfcYq3wmFN", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

