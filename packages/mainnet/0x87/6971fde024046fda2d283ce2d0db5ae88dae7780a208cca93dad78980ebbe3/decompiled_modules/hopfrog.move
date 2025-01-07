module 0x876971fde024046fda2d283ce2d0db5ae88dae7780a208cca93dad78980ebbe3::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 1670858456661167509, b"Hop Frog On Sui", b"HOPFROG", x"f09f90b822486f702046726f672053746172746572205061636b222020f09f90b8", b"https://images.hop.ag/ipfs/QmeBvJLiKpydNp9PdAavxAP5UBBqZ51GEBt7VwfVvxi82A", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

