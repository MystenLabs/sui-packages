module 0xf63f283c7a3be64f15ef395174b389edf6ad45ba4755508cae467908926b8e74::zombiex {
    struct ZOMBIEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIEX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ZOMBIEX>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ZOMBIEX>(arg0, b"ZombieX", b"Zombie", b"Shhsj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQqicqQa38R1DuJW6rE1mkkS3by7whFSVffr56Kph3a4r")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ed40d368e06330bc602f3c44439b58c3c607e5acb5091d60ff2ded37d50e15a73b0e7b356a661f4b01b4a7cc5481656bd153ec035a40310110398e3109d4ad0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758707"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

