module 0xcd11ec7471495dcb71b90e86d3eded838d9076ed603011efd18e56098fa92668::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<APT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<APT>(arg0, b"APT", b"APTOS", b"Aptos the Best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbVpGcQGUy3MwTGcHG67ZERQRRNcdi7shKewujo6cfEif")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00889f03716011120afd77a67ec738bcf5f6c10e87c2343f3881240a6866e0a299855373c322435b69e7ea3010e7896c219a37517f345d8ba3802551f388c69407d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747993720"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

