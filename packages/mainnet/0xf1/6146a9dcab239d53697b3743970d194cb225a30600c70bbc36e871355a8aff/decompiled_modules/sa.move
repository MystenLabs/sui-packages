module 0xf16146a9dcab239d53697b3743970d194cb225a30600c70bbc36e871355a8aff::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SA>(arg0, 15440474663367977006, b"Sea Angel", b"SA", b"Those who buy this coin are all idiots.", b"https://images.hop.ag/ipfs/QmQQ6591XMimgyZRgQstuG6CZdbCiTvew24BVVica7Y1eb", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

