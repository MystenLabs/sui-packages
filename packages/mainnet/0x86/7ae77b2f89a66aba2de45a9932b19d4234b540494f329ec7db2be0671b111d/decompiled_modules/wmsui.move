module 0x867ae77b2f89a66aba2de45a9932b19d4234b540494f329ec7db2be0671b111d::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<WMSUI>(arg0, 9351105955994815586, b"WATERMAN", b"WMSUI", b"Waterman, the SUIperhero. Be water MF.", b"https://images.hop.ag/ipfs/QmVQ6cEBNCohBrAa5j7uXJBPuUjgZ3QE5JXfkxi5FMFDYY", 0x1::string::utf8(b"https://x.com/Waterman_SUI"), 0x1::string::utf8(b"https://watermansui.com/"), 0x1::string::utf8(b"https://t.me/waterman_SUI"), arg1);
    }

    // decompiled from Move bytecode v6
}

