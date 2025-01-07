module 0x38a69b48ec72bd8322e7cf9733ebdfca6aaa77e9c0735d8d2b4268f30d77480a::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<EGG>(arg0, 5044992337345684826, b"Just Egg", b"egg", b"Just an egg in this big scrambled world", b"https://images.hop.ag/ipfs/QmboX3ZBz5GVYDDSztjnFsxHR5oqcfBuZwWuDx3TEpFNwd", 0x1::string::utf8(b"https://x.com/justeggsui"), 0x1::string::utf8(b"https://justegg.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

