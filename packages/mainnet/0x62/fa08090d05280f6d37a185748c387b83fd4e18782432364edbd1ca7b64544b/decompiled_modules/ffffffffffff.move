module 0x62fa08090d05280f6d37a185748c387b83fd4e18782432364edbd1ca7b64544b::ffffffffffff {
    struct FFFFFFFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x124f062a1eb37f9ec5f87bdc3cba16664fddcdd97f4ae1c2f4b0669992afbb41::connector_v3::new<FFFFFFFFFFFF>(arg0, 892408424, b"FFFFFFFF", b"ffffffffffff", b"ffffffffffffffff", b"https://ipfs.io/ipfs/bafybeic57e2n66q6tx4ekemblbnu26zkbquzvpnp4af4llgikb6pqn7s5i", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

