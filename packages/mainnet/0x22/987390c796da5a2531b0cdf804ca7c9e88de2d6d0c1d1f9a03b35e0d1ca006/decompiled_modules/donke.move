module 0x22987390c796da5a2531b0cdf804ca7c9e88de2d6d0c1d1f9a03b35e0d1ca006::donke {
    struct DONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DONKE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DONKE>(arg0, b"DONKE", b"DONKE on SUI", b"Donke, the carrot lovin', buck-wild degen, kickin' on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVELLJhgf1XXEksHAeobBqVZ7BzARgNE1UNAAV48AR8Am")), b"https://www.donkeofficial.com/", b"https://x.com/donke_on_sol_", b"DISCORD", b"https://t.me/DONKEonSOLmemes", 0x1::string::utf8(b"00d50c392058754f739d5a40e44544c30323bd644f3476b4275bc3f2b1b85a76cbdaef56f42b578850e19b2f3402f867db0246244177f9768c0fcc84bca51ed606d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758088"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

