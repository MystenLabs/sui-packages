module 0x1891c2c5168799383eb706ec73213604275eb2d95c42ac8a0773155775c5e7f6::yes {
    struct YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: YES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<YES>(arg0, 16122401372322162412, b"twoshoes", b"yes", b"killem", b"https://images.hop.ag/ipfs/QmeocE6xS3nECyz9F9gn9U5JhwEm4yHHPd6eZiphMLXjtP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

