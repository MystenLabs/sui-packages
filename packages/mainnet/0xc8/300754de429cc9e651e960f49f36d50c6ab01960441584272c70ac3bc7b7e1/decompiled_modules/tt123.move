module 0xc8300754de429cc9e651e960f49f36d50c6ab01960441584272c70ac3bc7b7e1::tt123 {
    struct TT123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT123, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT123>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT123>(arg0, b"TT123", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00662de683541c78caf08a5d6206a41de55b5f776f0f2f3c27d6bab22dd56ee983e41f8a0cba837e55fe7f8e05dbbaf45784d772c6507342bb22663950b5cda905ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747063642"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

