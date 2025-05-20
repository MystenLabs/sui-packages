module 0x8b1a2be60063d993db462fd5c52f28bf7700626670591e29c6c70a460c3de9f6::cds {
    struct CDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CDS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CDS>(arg0, b"CDS", b"crypto drop scout", b"a community backed token cds join us and lets celebrate together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTNHgApQJbP3EeAJYnfRiReo7wz9LoXr5tTHyXfe6Snt8")), b"https://t.me/CryptoDropScoutt", b"TWITTER", b"DISCORD", b"https://t.me/CryptoDropScout", 0x1::string::utf8(b"00c227a5a20ba8fcd58b041b36c711384c11c6ec33ce4b404b654b9e1bcf8a787e35592e321591228a70f8e9bc9308f68940c9036a522a03a4d80734cdd06edd09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747773684"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

