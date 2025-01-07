module 0x8fad139d0be23aaec4c1435af3f2e60c9cf09ab2b22755b27a809d64269e870b::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TJ>(arg0, 2202564578982776040, b"not.fun", b"tj", b"WTF IS GOING ON", b"https://images.hop.ag/ipfs/Qmcoa7QxVSdAmgSARxJQwFoXNsUAvmdfkNtPS843hxix3C", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

