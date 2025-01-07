module 0x3dc9e3ed4137cdf192c075bfeea263669a82db66c848cd5d0bbc08d8ac3275be::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LUFFY>(arg0, 5241877599452839397, b"SuiOnePiece", b"LUFFY", b"SuiOnePiece is a unique digital asset built on the Sui blockchain, inspired by the adventurous and ambitious spirit of the \"One Piece\" theme. Designed to embody values like discovery, growth, and community, SuiOnePiece offers holders not just a token but a journey of opportunities within the Sui ecosystem.", b"https://images.hop.ag/ipfs/QmXqq42zure6LtCxqfVvEo82jnNchAktuQeDSKWZTfSm2L", 0x1::string::utf8(b"https://x.com/SuiOnePiece"), 0x1::string::utf8(b"https://suionepiece.art"), 0x1::string::utf8(b"https://t.me/SuiOnePiece"), arg1);
    }

    // decompiled from Move bytecode v6
}

