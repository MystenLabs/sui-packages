module 0xf705c1f2702b6fe4453f0c252550198ef91ae143763cfd72cc1db028078c6a38::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 16890865884559640321, b"Hop Frog On Sui", b"HOPFROG", x"5765206172652066696e616c6c79206f70656e696e6720746865206761746573210a4a6f696e2074686520e6b0b4446f6a6f2120f09f90b8", b"https://images.hop.ag/ipfs/QmTxbz97of1u62TjusUGxJqcJFEeawkCoTQ54TR4FbEPbd", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

