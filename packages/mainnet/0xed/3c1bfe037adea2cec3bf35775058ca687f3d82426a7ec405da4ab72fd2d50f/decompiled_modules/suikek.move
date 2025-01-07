module 0xed3c1bfe037adea2cec3bf35775058ca687f3d82426a7ec405da4ab72fd2d50f::suikek {
    struct SUIKEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIKEK>(arg0, 11731176116537951295, b"SUIKEK SUMIXAM", b"SUIKEK", b"It's just KEKSIU MAXIMUS went on a reversal and now has reborn on the waters of SUI ;)", b"https://images.hop.ag/ipfs/QmTRZn76o4Ez1bGRJV436y7tvuUyhtfe7MMBQ2Z8NwmL5T", 0x1::string::utf8(b"https://x.com/SUIKEKSUMIXAM?t=PbgFqBBNphqfwdLM5Amwnw&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/ReversalKeksiuOnSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

