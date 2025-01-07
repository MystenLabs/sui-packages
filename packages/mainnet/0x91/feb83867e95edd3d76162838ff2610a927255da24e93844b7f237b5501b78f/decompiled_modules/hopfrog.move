module 0x91feb83867e95edd3d76162838ff2610a927255da24e93844b7f237b5501b78f::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 3690268797161802915, b"HopFrog", b"HopFrog", b"LFG", b"https://images.hop.ag/ipfs/QmWSdmbGzQpNxNU3VPW1nVnoQfct9oAU96jLsEFnUe5ma5", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

