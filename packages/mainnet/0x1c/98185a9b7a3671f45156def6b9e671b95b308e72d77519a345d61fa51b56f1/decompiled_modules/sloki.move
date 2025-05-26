module 0x1c98185a9b7a3671f45156def6b9e671b95b308e72d77519a345d61fa51b56f1::sloki {
    struct SLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SLOKI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SLOKI>(arg0, b"SLOKI", b"SloKing", b"SloKing! The Pokemon meme king on SUI. First of its kind. Stake, vault NFTs, and rule with the king.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaGVbyYYRCrBUE3whnQ6XQzpLfn1hzy6HyVSpZma1JUdv")), b"WEBSITE", b"https://x.com/slokingonsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005b150d3646d2251fe5b4f2bd924bc322e3e1b63f328ae4d491de5d65613f0de5daa692ca2302041543e0b592281b2babbe3dacf9c424b3660e0344ef35364403d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748250077"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

