module 0x3b3a3b3516ba1a5a589d651cb2b2f59b4fe0f72d2a2289edbea94bb7de49ae1d::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUICIDE>(arg0, 12761144239993983532, b"Suicide", b"SUICIDE", b"It's finally possible to own a real suicide stack", b"https://images.hop.ag/ipfs/QmU7FYmA7dzcrs5wzwKvVHWeuRtqi5Bc9TRgFFbU3xZtUv", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+jIE7tTIsoSk3YzBk"), arg1);
    }

    // decompiled from Move bytecode v6
}

