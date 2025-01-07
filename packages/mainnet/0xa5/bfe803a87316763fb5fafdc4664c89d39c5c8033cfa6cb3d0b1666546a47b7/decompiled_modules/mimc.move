module 0xa5bfe803a87316763fb5fafdc4664c89d39c5c8033cfa6cb3d0b1666546a47b7::mimc {
    struct MIMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MIMC>(arg0, 15025949320503120389, b"Make It Make Cents", b"MIMC", b"The first Meme that Makes It Make Cents", b"https://images.hop.ag/ipfs/Qme1oC1dhf9xjBt9VMhQmbXTckPyDgbw9N32HFrshQjhnA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

