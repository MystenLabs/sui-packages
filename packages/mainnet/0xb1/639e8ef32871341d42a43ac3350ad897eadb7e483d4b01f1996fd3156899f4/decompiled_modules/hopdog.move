module 0xb1639e8ef32871341d42a43ac3350ad897eadb7e483d4b01f1996fd3156899f4::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPDOG>(arg0, 1532877717049434560, b"Hopdog", b"HOPDOG", b"$HOPDOG, Sui's and Hop's best dog!", b"https://images.hop.ag/ipfs/QmRa19QZvt9RGCr4Vc8pDVQuvqhXLdZJtbCrqSXp4tipet", 0x1::string::utf8(b"https://x.com/hopdog_sui"), 0x1::string::utf8(b"https://hopdogsui.fun/"), 0x1::string::utf8(b"https://t.me/hopdogsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

