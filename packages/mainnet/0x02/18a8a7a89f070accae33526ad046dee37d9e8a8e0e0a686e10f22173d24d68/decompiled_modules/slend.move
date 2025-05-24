module 0x218a8a7a89f070accae33526ad046dee37d9e8a8e0e0a686e10f22173d24d68::slend {
    struct SLEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEND, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SLEND>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SLEND>(arg0, b"SLEND", b"SuiLEND", b"Sui Lend Sui Lend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma293RMBU7szFd5BPpChyXQWGbdPozTGD2pDqf5aTRMMS")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004514727df45bf1bd9c144ef5eec05ccb76308830e38e946e0994679ef6c1c9183a9321f6df8d5b736206078fd92185bacb0a2393cedc1366ec8f77c7373b690cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748097512"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

