module 0x5f71964d4adafdcddedd4fa8cba275fb06f61d149ed11bc6b7dbbe399e4d4162::nj {
    struct NJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NJ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NJ>(arg0, b"NJ", b"NIJIA", b"Here comes your favorite Ninja warrior!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmerfRRhtpkJ11zTyGCiq1Zv4vUkPD8BSyNh8SPpYwMaN1")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007a5078f4ad59c1ce8fa5d69c44bbbfc611a5b25a873df74a38c10143de8b01ef78cd3561802a2919019ab184f20bf161e0e9f52313867a201571919bb6fda00ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747832911"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

