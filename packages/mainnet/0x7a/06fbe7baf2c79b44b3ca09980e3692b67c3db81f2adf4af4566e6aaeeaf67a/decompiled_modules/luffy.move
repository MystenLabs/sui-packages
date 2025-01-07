module 0x7a06fbe7baf2c79b44b3ca09980e3692b67c3db81f2adf4af4566e6aaeeaf67a::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<LUFFY>(arg0, 11202019469116835770, b"SuiOnePiece", b"LUFFY", b"SuiOnePiece is a unique digital asset built on the Sui blockchain, inspired by the adventurous and ambitious spirit of the \"One Piece\" theme. Designed to embody values like discovery, growth, and community, SuiOnePiece offers holders not just a token but a journey of opportunities within the Sui ecosystem.", b"https://images.hop.ag/ipfs/QmXqq42zure6LtCxqfVvEo82jnNchAktuQeDSKWZTfSm2L", 0x1::string::utf8(b"https://x.com/SuiOnePiece"), 0x1::string::utf8(b"https://www.suionepiece.art/"), 0x1::string::utf8(b"https://t.me/SuiOnePiece"), arg1);
    }

    // decompiled from Move bytecode v6
}

