module 0x89ffd4564a6a8003cad0bf4dc0d253339c38f20890b6be20e77d6789047abde6::suiperdoge {
    struct SUIPERDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIPERDOGE>(arg0, 17370990697791958280, b"SUIPERDOGE", b"SUIPERDOGE ", b"SUIPER is Meme Coin of Super Dog", b"https://images.hop.ag/ipfs/QmWEZqeRdSxbq3SmcAMaxj5XmFjxe8KrY6eqcMeShFXCYJ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

