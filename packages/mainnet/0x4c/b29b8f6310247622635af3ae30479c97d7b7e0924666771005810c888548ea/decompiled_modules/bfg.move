module 0x4cb29b8f6310247622635af3ae30479c97d7b7e0924666771005810c888548ea::bfg {
    struct BFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BFG>(arg0, 2379048341459985632, b"Bigfoot", b"BFG", b"Bigfoot has arrived to establish its presence on the blockchain via the SUI network. Join this distinctive community and grow alongside Bigfoot.", b"https://images.hop.ag/ipfs/QmVjrn9aYZNiAihLTLh3Db3kyLXhiUqypJmAyTY4E8onQs", 0x1::string::utf8(b"https://x.com/BigfootBFG1?t=BI4MtaeOEpmA4W01LLCd1Q&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

