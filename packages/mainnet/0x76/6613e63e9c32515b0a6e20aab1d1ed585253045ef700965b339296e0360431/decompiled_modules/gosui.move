module 0x766613e63e9c32515b0a6e20aab1d1ed585253045ef700965b339296e0360431::gosui {
    struct GOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GOSUI>(arg0, 3827875453720924212, b"GoSuilla", b"GOSUI", b"Gosuilla is coming to $sui to destryo all the other chains", b"https://images.hop.ag/ipfs/Qmejws2hKXeAuinHHsZN46WaKKTYwfMVuXuWGy4qTATgVh", 0x1::string::utf8(b"https://x.com/GosuillaOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/GoSuilla"), arg1);
    }

    // decompiled from Move bytecode v6
}

