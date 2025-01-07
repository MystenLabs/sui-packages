module 0x3ac157a8b6a4261aed72e40bf35af44350b371a20e709b4a2b196a387d15cc1e::agentkit {
    struct AGENTKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTKIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AGENTKIT>(arg0, 10741051700900505602, b"AgentKIT", b"AgentKIT", x"4167656e744b697420686173206c61756e63686564202d206974e2809973206e6f77206576656e2065617369657220746f2063726561746520616e204149206167656e74207769746820612063727970746f2077616c6c65742028616e64206f7074696f6e616c20736f6369616c206163636f756e7429", b"https://images.hop.ag/ipfs/Qmer3bM5aikPFshY7zNybz2k9R1gkuWQGiW68PmV31PYbD", 0x1::string::utf8(b"https://x.com/brian_armstrong/status/1854987061696328166"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

