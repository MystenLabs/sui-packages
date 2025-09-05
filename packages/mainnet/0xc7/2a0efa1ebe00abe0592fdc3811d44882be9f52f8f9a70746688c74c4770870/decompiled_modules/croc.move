module 0xc72a0efa1ebe00abe0592fdc3811d44882be9f52f8f9a70746688c74c4770870::croc {
    struct CROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<CROC>(arg0, b"Croc", b"Crocky", b"First Blue bird on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmekWMqJ7KJertaucqPFc5v8kshGFefpzAZKgFokouMwNR")), b"WEBSITE", b"https://x.com/Crockymeme", b"DISCORD", b"https://t.me/Crockymeme", 0x1::string::utf8(b"00dd6194e933e415a9ff06590a676949748d290306983e8eb01eee6378beae3f6ee86e880b0388c704ffb946c44efa3a8c1e35f16261ba1ce733a256a25d009207d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757076505"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

