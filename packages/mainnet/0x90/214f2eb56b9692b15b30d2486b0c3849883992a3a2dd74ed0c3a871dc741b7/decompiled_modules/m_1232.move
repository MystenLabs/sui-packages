module 0x90214f2eb56b9692b15b30d2486b0c3849883992a3a2dd74ed0c3a871dc741b7::m_1232 {
    struct M_1232 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_1232, arg1: &mut 0x2::tx_context::TxContext) {
        0xc128bbcd3ebc450822c2f64f2defb727bccb9e255277b04979b41a8f4ae0318::connector_v3::new<M_1232>(arg0, 1000, b"123", b"M_1232", b"2131 by suifun", b"http://127.0.0.1:8000/api/v1/blob/MyJ819o1RaH2H2LgTU9I-rbskjdlk6mHlAeeqvmHtgc", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

