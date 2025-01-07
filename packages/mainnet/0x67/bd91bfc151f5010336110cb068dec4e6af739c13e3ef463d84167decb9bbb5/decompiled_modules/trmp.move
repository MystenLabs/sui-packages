module 0x67bd91bfc151f5010336110cb068dec4e6af739c13e3ef463d84167decb9bbb5::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRMP>(arg0, 9259636891419181656, b"TRUMP", b"TRMP", b"next president of america", b"https://images.hop.ag/ipfs/QmbnpJYau6utHizPpjaEzCQ8M1FYNkPGTpajq3uZraJYiH", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

