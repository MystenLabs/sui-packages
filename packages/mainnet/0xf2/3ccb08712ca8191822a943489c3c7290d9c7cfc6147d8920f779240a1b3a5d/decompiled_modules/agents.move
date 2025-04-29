module 0xf23ccb08712ca8191822a943489c3c7290d9c7cfc6147d8920f779240a1b3a5d::agents {
    struct AGENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<AGENTS>(arg0, 729512722, b"AGENTS", b"agents", b"Agent S is the king of sui meme", b"https://ipfs.io/ipfs/bafybeif34xynyahmdihlim77ww4kieeaiby23adnljmw7gfn37m2r5ktli", 0x1::string::utf8(b"https://x.com/herer"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://t.me/here"), arg1);
    }

    // decompiled from Move bytecode v6
}

