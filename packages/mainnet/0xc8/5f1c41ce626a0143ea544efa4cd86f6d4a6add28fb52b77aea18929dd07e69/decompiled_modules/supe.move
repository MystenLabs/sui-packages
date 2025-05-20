module 0xc85f1c41ce626a0143ea544efa4cd86f6d4a6add28fb52b77aea18929dd07e69::supe {
    struct SUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUPE>(arg0, b"SUPE", b"SUISUPE", b"BEST BLOCKCHAIN MEETS CREATIVITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRaMUkEfZTHgtryRgMaWnkaU18GmVDKFgsydEKcx3PFeh")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bb505b0909cf7c5dddbf7214bb63c82b44209d7fdecef7f6dd08dc9ee82cf485b73a4b39280bf8c7946ee2a2c159a5594a80b064c1698d89a92d2101bc2c1d06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747774215"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

