module 0xb9ada1a6250c2ba2e1d22cbe5914642d8bf16ca65508e039f7ddb8062ae7cf71::ihop {
    struct IHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IHOP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<IHOP>(arg0, 812566475409076054, b"International House of Pump", b"iHOP", b"The time has come to join iHOP for an Up Only adventure to the moon !", b"https://images.hop.ag/ipfs/QmePnzEbTeRwvRg6zqTQPPCypGiC4WhntRonimuQGP8hNF", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+64kqRI_5UnlmNjFl"), arg1);
    }

    // decompiled from Move bytecode v6
}

