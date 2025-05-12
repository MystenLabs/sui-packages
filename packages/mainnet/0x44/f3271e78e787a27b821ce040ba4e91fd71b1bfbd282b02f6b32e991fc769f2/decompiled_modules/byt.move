module 0x44f3271e78e787a27b821ce040ba4e91fd71b1bfbd282b02f6b32e991fc769f2::byt {
    struct BYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYT, arg1: &mut 0x2::tx_context::TxContext) {
        0x40998f8c129db75ae10a24a20d0d92ad99206b308f63a59cf29418cc19542f53::connector_v3::new<BYT>(arg0, 336103205, b"BYT", b"byt", b"bytbytbytbyt", b"https://vram.mypinata.cloud/ipfs/bafkreiciuditpnnrcfzfhaabz7tgxvanazfbdhdltic62ixx4kceydmsde", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

