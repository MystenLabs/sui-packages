module 0x1cf0a5d50b411b2f377132933d31beffbb0b37ad0beb04ab4da0e4cbdcf95b5f::jaw {
    struct JAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAW, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<JAW>(arg0, 2704905984110019664, b"JabberJaw", b"JAW", b"The ultimate meme coin making waves in the crypto ocean! Inspired by the iconic, lovable, and hilarious talking shark from the classic cartoon, Jabberjaw, this coin is here to bring fun, laughter, and financial fin-tasticness to the blockchain.", b"https://images.hop.ag/ipfs/QmW6R4D3zvUEZD7SstwT5eWtDxaWQ48thJFamoFozNXYAp", 0x1::string::utf8(b"https://x.com/SuiJabberJaw"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/suijabberjaw"), arg1);
    }

    // decompiled from Move bytecode v6
}

