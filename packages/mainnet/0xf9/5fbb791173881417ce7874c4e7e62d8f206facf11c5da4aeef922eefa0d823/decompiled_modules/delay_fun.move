module 0xf95fbb791173881417ce7874c4e7e62d8f206facf11c5da4aeef922eefa0d823::delay_fun {
    struct DELAY_FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELAY_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DELAY_FUN>(arg0, 3700574193238962922, b"delay.fun", b"delay.fun", b"who actually needs to launch on time? certainly not hop.fun", b"https://images.hop.ag/ipfs/QmRG9EaQBCXrWfdAUnKe2hyrho4tN69DVKPSgQMAAcCQdK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://www.delayz.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

