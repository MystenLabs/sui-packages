module 0x2a54cea25949b701689e106817ffb3929a6aa7e01369884c9b678d5f5953edd9::smol {
    struct SMOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SMOL>(arg0, 1602288238203550332, b"Smol Sui", b"Smol", x"536d6f6c205375206861732061727269766564206f6e205375692e0a0a546865205355494e414d4920697320636f6d696e672e200a0a5355497065726379636c6520287265616c292e", b"https://images.hop.ag/ipfs/QmSZT9Hz6DYYkGbcFa9HJQDaeMwyKcZ7bZyaLExXqfRRGS", 0x1::string::utf8(b"https://x.com/SmolSuiReal"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

