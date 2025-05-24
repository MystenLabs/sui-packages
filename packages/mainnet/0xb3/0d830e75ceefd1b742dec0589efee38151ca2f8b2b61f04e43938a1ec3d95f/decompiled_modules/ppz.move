module 0xb30d830e75ceefd1b742dec0589efee38151ca2f8b2b61f04e43938a1ec3d95f::ppz {
    struct PPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PPZ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PPZ>(arg0, b"PPZ", b"PepPIZZA", b"Pizza deliver who agree that pineaple is not toping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY9KDGxtsqGCQUE63csRVEsyQ3M3FA6jyiRqJ2ViHGwag")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008f1ee103cc1b849cd567a3569ab023b541333e8c83831db5289c3ec8d088fb20db20de152f69740b91a42cad6f5e93c54a3ff001861db153538c615fb3243b08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748086266"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

