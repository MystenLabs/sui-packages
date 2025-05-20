module 0xea1c584ad52cd285fc7ec81cadfc9736ae20f1c45b50b0f98d2dbec24c37ccb6::suibtc {
    struct SUIBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIBTC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIBTC>(arg0, b"SUIBTC", b"SUI BTC", b"The BTC on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZRhGe5JxioeiUQ9F78r3zs24ggWV76MrQCSgPrcGphYx")), b"WEBSITE", b"https://x.com/BTCMarkets", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ac64837b4e30ca025176784de68f690a48ae276f0c19e119b63424bead61e8428411ee0b32ed5e3869a6e2958ce10b80e8158f3a31c6fa2e3cde1a040a52d700d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758572"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

