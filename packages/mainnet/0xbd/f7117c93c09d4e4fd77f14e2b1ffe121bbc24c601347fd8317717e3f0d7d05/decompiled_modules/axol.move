module 0xbdf7117c93c09d4e4fd77f14e2b1ffe121bbc24c601347fd8317717e3f0d7d05::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AXOL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AXOL>(arg0, b"AXOL", b"AXOL Coin", b"AXOLcoin, the OG amphibian on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRSUjWkbC6DYovfaeK24keBQ5XnCzHqKrkc9gb4EDPkDg")), b"https://axolcoin.xyz/", b"https://x.com/AxolOnSui", b"DISCORD", b"https://t.me/AxolSUI", 0x1::string::utf8(b"0089b6f2e3e6aabe0ececdf9e9ff1ac822f8549a0a523c397466866a57ca9ba982e3d7fdcccd99c27dd8302b5626d24a53ef4d67ef359f7ee9b26352fb18fc990cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757571"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

