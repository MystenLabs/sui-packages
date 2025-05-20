module 0x87abe7fc82dd957ec82315c0e64fc610d1a5de154cd4f3c3115658f96c698c02::kobushi {
    struct KOBUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KOBUSHI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KOBUSHI>(arg0, b"KOBUSHI", b"Kobushi", b"The baby pygmy hippo at Ueno Zoo named Kobushi is coming on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXF7bhkCyTiawU5KuSzVLiuVMPnAML9Byykm66sbHFR5D")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0007b12934d1ec4fd58268a6d42c45546ccbad903aa8fcc53416b75f01ee8ebbb2bc4dbd12caeca6855aee28eb704c53149cbd6d0e9c488e6836a941600c975c0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756981"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

