module 0xa19c752edd94d4f1a9766b561bf68f98d70f0551b36d15a68b7745dfeeac8479::tdy {
    struct TDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TDY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TDY>(arg0, b"TDY", b"Teddy", b"I'm selfish, impatient and a little insecure. I make mistakes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcuKLYSNFySyy1qs1CT2mG7uvVKAPgn5QGUEN5sBm5Hn4")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d75152e23b226797f71a33d3f08e7b86f7d5dc0d63e4af89f368d72c5799a90da4ec2536fab90dbed45d6fff3e0492036ca3698e1b5c1af90f8c667bc402ac09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748219743"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

