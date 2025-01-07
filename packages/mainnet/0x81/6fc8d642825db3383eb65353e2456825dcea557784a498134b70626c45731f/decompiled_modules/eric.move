module 0x816fc8d642825db3383eb65353e2456825dcea557784a498134b70626c45731f::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ERIC>(arg0, 4910828896431135132, b"ERIC", b"ERIC", b"Eric is common universal . Lets make ERIC the king of names by sending it to 777 billion USD market cap", b"https://images.hop.ag/ipfs/QmPRayiHqi9AUnobb1FdHLzzBCPGV9E6ge73NargtanAon", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

