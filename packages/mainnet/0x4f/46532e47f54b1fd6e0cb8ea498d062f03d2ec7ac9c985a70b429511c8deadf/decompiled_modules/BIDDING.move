module 0x4f46532e47f54b1fd6e0cb8ea498d062f03d2ec7ac9c985a70b429511c8deadf::BIDDING {
    struct BIDDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIDDING, arg1: &mut 0x2::tx_context::TxContext) {
        0x80720f8aa621edc4fb6fbc72069352d6d539bb8e74d36f43e85c5a3dfea2748d::connector_v3::new<BIDDING>(arg0, 1000, b"bidding", b"BIDDING", x"42696464696e672062792073756966756e20f09f9887", b"http://127.0.0.1:8000/api/v1/blob/fndxh6k2vcv2MaHJFP_iZYeTB-5cm7KMHoOQ5-x5IBg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

