module 0x508bb7471104c3533612b643fe29fd7aa38bcf5f5e8cfbffc12b11b147dff204::spien {
    struct SPIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPIEN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPIEN>(arg0, b"SPIEN", b"SUIPIENS", b"OG Community on $Sui Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVEat2KWgtd81ypJuQpSrkNhR1TYUgqDUbLdf7CJEWjto")), b"suipiens.com", b"https://x.com/suipiens", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00277cfb7cab954207f5f8289bd2d382245de84b41aa6959b2c2c9d4dd1d6e1b91ec417468879a5f6ab305f00352398f4f96632dd826f83eb7c0849659c5345b0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759339"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

