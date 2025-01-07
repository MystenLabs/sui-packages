module 0x3992359acc2d23e7b071af6428626489d68ad6d04056fd625d2839f2e2450c4::beesui {
    struct BEESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEESUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BEESUI>(arg0, 1584098979583913136, b"BEE ON SUI", b"BEESUI", b"BEE for the people. The sweetest token on Sui. Our community is bond together with honey.", b"https://images.hop.ag/ipfs/QmdEyqeAMoMiUt9zfSziEFcNt67eHdfQirYgiCqREa7S5g", 0x1::string::utf8(b"https://x.com/beesuiofficial"), 0x1::string::utf8(b"https://suibee.fun/"), 0x1::string::utf8(b"https://t.me/beesuiofficial"), arg1);
    }

    // decompiled from Move bytecode v6
}

