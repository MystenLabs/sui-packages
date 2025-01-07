module 0xfd234471b35684ae0b7286f907ebb2f6225ae5d7e15af886d3df16ca361cb82::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPDOG>(arg0, 9944158949242617996, b"HOP DOG", b"HOPDOG", b"$HOPDOG, Sui's and Turbo's best dog!", b"https://images.hop.ag/ipfs/QmR8ejbMWAEq6q41fG5BMD3vfeySLShYQQ54BCv1FZKRH6", 0x1::string::utf8(b"https://x.com/hopdog_sui"), 0x1::string::utf8(b"https://hopdogsui.fun/"), 0x1::string::utf8(b"http://t.me/hopdogsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

