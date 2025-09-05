module 0x24a1eed9f0d23beaa6175eb1c13eca31084282ce3933a6c4d48427ad3aa640a::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SPEPE>(arg0, b"SPEPE", b"SPEPES", b"SPEPE  MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmepxRQYhwRrWUxn5Cg24LFtRFdS39HACeCtknp7cZp3hg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c2bff403def221d7a1629113f1e3a21f3bf01b7d3b6abad6e3e0c8b31c5fd5d833a69469dd94c56a3d69677f5f0fa7c5e51a33c4dbd1f6b17c5f996c42a26400d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757067324"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

