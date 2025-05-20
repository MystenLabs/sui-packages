module 0xca74937c21bcc379b99c90c932bf7b2fcde375a4ead8e72fee20f9f24468c169::suixol {
    struct SUIXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIXOL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIXOL>(arg0, b"Suixol", b"Suiaxol", b"Suixol on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZYump3Ah1K3WCPnsjsZymhoU3vRdjciwjM9jvTnLQXLK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a208edcd2c9bafc38e10fd3ffceffd67da6def3064201042637fdeaa415da6100cecc34344248009ff7caa9138d2664f9f4de5441fe10ef0f02ecb57a4244305d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747764917"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

