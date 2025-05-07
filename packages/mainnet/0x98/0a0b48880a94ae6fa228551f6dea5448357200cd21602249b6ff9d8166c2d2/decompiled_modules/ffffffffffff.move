module 0x980a0b48880a94ae6fa228551f6dea5448357200cd21602249b6ff9d8166c2d2::ffffffffffff {
    struct FFFFFFFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x124f062a1eb37f9ec5f87bdc3cba16664fddcdd97f4ae1c2f4b0669992afbb41::connector_v3::new<FFFFFFFFFFFF>(arg0, 777239489, b"FFFFFFFF", b"ffffffffffff", b"ffffffffffffffff", b"https://ipfs.io/ipfs/bafkreieyncggkmtftly7ltxkkalzlonhtdw7hcdouvvdg4izc32nik6vpu", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

