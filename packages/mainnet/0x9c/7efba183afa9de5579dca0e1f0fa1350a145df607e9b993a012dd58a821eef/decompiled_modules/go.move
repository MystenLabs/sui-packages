module 0x9c7efba183afa9de5579dca0e1f0fa1350a145df607e9b993a012dd58a821eef::go {
    struct GO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GO>(arg0, 2500376548274036200, b"GOOOOOOO", b"GO", b"GO", b"https://images.hop.ag/ipfs/QmSp5qvotw74ztaawhcqMpdJVaacdMZCFHS7dNHHicgQPj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

