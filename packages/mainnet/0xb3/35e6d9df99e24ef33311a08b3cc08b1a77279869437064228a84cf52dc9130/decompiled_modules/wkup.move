module 0xb335e6d9df99e24ef33311a08b3cc08b1a77279869437064228a84cf52dc9130::wkup {
    struct WKUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKUP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WKUP>(arg0, 860655421628321515, b"You finally woke up", b"WKUP", b"Prosnulsia Nahuy?", b"https://images.hop.ag/ipfs/QmeS34B9LTZHrrQ3FHWXZfZWDTSoKtBi3GzDbZ1Xzyvw5v", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

