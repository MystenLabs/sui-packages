module 0x6bf20067647fd30b22ce24a22d0640094212a2e772efe5a301a28ad21bae4a56::suittles {
    struct SUITTLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTLES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUITTLES>(arg0, 12962935102488647872, b"Original Suittles", b"Suittles", b"want some suity? Get some Suittles. The Suipreme quality Suites.", b"https://images.hop.ag/ipfs/QmbVTZHhJ7MRqJzNmePU3FTpJMjpf39tqzevcJoC3MmxWU", 0x1::string::utf8(b"https://x.com/suimemex/status/1848410668124541216"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

