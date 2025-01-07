module 0x93ee5d8281055ca97d40357a5e98b21a0b356962f11725664858f87cb6d3adc2::dtllc {
    struct DTLLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTLLC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DTLLC>(arg0, 12947159714667366275, b"DiceCo", b"DTLLC", b"The official token of DiceCo Technologies, LLC.  It has no intrinsic value or use.  It's just a super-nerdy thing to do for a super-nerd with a nerdy company that builds on-chain solutions for customers.", b"https://images.hop.ag/ipfs/QmXBBmc2FHhh6WFAx3SaP1gpkW29RHWMVA1PiSgU41q7DS", 0x1::string::utf8(b"https://x.com/DiceCoTech"), 0x1::string::utf8(b"https://diceco.io"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

