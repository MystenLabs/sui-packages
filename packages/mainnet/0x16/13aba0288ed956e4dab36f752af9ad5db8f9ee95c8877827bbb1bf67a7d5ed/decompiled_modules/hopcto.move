module 0x1613aba0288ed956e4dab36f752af9ad5db8f9ee95c8877827bbb1bf67a7d5ed::hopcto {
    struct HOPCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCTO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCTO>(arg0, 3419391386420125315, b"HOP TIME DRAINER", b"HOPCTO", b"The easiest way to lose time on Sui. Swap your time for anything while the redneck dev laughs at you on telegram!", b"https://images.hop.ag/ipfs/QmdeKP6WQJVZ5Ct9EF1p2xteTec1QZA3fFXksrEvbPqFTH", 0x1::string::utf8(b"https://x.com/HopCto"), 0x1::string::utf8(b"https://www.hopcto.fun/"), 0x1::string::utf8(b"https://t.me/HOPFUNCTO"), arg1);
    }

    // decompiled from Move bytecode v6
}

