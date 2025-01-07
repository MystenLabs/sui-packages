module 0x82b136d18387726bcfe5d60a13c6681baf0e0c6d95380ad2fdf7b0eced736bb0::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FENG>(arg0, 3925697356393029258, b"FengSui", b"FENG", b"FengSui Coin is a cryptocurrency inspired by the timeless principles of Feng Shui, designed to bring balance, harmony, and prosperity to the digital economy. Rooted in the philosophy of energy flow and positivity, FengSui Coin integrates sustainability and growth, empowering users to align their financial journey with the natural forces of abundance and tranquility. Its elegant design and functionality aim to promote well-being and wealth for all who embrace it.", b"https://images.hop.ag/ipfs/QmRTYeC2zVK9UasQnaojdpiwkokj7YCtoedKASFTph3bBN", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

