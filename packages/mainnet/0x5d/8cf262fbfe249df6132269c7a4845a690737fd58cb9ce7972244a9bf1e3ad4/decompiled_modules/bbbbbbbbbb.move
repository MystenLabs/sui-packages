module 0x5d8cf262fbfe249df6132269c7a4845a690737fd58cb9ce7972244a9bf1e3ad4::bbbbbbbbbb {
    struct BBBBBBBBBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBBBBBBBB, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<BBBBBBBBBB>(arg0, 850557639, b"BBBBB", b"bbbbbbbbbb", b"bbb", b"https://ipfs.io/ipfs/bafkreidtmkdykktzo7bhsxivka5cwi5crqckotsapt4vhpbigvet2db4ri", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

