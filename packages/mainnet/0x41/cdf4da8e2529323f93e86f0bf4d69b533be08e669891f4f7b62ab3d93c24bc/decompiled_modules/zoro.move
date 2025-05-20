module 0x41cdf4da8e2529323f93e86f0bf4d69b533be08e669891f4f7b62ab3d93c24bc::zoro {
    struct ZORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ZORO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ZORO>(arg0, b"ZORO", b"Zoroark On Sui", b"Zoroark is on Splash now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQrxRrKQYnzmqjSq8KffXEZPxuY4raVhjoSRnyvJxcDE3")), b"WEBSITE", b"https://x.com/Suiderace", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00305ffc50e253e9ba9118b2757c4c95ba16d491d661fb14ff57e4fc477bb81a7264f40e7e827f79e99937cd4aa076002fedd80c469aa23de1ebd2e66e9f21c30cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756774"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

