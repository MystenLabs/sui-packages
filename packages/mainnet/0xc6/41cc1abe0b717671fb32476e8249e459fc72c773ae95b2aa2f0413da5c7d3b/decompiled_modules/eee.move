module 0xc641cc1abe0b717671fb32476e8249e459fc72c773ae95b2aa2f0413da5c7d3b::eee {
    struct EEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEE, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<EEE>(arg0, 333775532, b"EEEE", b"eee", b"eeee", b"https://ipfs.io/ipfs/bafkreihrbf36jltzdsk4evqfsbgpau5cbx6pgv2oyleigonvp5jilqyhhy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

