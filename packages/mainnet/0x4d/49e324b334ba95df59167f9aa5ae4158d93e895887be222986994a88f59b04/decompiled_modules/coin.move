module 0x4d49e324b334ba95df59167f9aa5ae4158d93e895887be222986994a88f59b04::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<COIN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<COIN>(arg0, b"Coin", b"Suicoin", b"Whoever possesses it will become rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX6UkrYuiifRuv8Fu9BnCmiYT4L7rMeqEBw1dSxzDTqqU")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f1719ef6e46509941a97b58edf0cc6778008d143c2f5ca596eac8c26c2a8ecd92b793ca8960c629e944b9ebb55e086501d240a116f21d69d73e04d8db041530ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747831257"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

