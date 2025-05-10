module 0x123e62fffc48e2781edb9d3c569186822b56358b4e0e39799da9070d48a2ccbb::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<GGG>(arg0, 662664769, b"GGG", b"ggg", b"gg", b"https://ipfs.io/ipfs/bafkreibr6n46se3mbi6eoj74gww6dxticssnx6alvbkq3bhcxtzyb7pasm", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

