module 0x84875229dbb39606e08eb759b7e5b311f4095a6f61af484d11c46e7311906e6f::percy {
    struct PERCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERCY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PERCY>(arg0, 14760840736310396409, b"Percy Verence", b"Percy", b"Elon Musk official", b"https://images.hop.ag/ipfs/QmTaGQ3CRRpeCwj5u4KZE7LFS4gW1cRygrAuFWrgxMRHFK", 0x1::string::utf8(b"https://x.com/elonmusk/status/1875520043662164148"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

