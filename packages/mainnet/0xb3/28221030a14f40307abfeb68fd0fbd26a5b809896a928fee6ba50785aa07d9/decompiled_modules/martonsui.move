module 0xb328221030a14f40307abfeb68fd0fbd26a5b809896a928fee6ba50785aa07d9::martonsui {
    struct MARTONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MARTONSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MARTONSUI>(arg0, b"MARTONSUI", b"Marathon", b"Success is a marathon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTNGyNywPm8zJ4ikoeJHTfmYuxSLbCWmt1LC7QwtaNB7X")), b"https://x.com/Lordmarathonx?t=vxvm4d32ie8yUgsOYQhs4Q&s=09", b"TWITTER", b"DISCORD", b"https://t.me/decryptomanians", 0x1::string::utf8(b"0021ef5c777a0be91466f7fdf7a9dfe5f0d0f6537a6bd1c0aade0daa71fbb82d2277dd68fd9047f771842cbdca0627b7f1f9a859ad935ef0dcf3af6875664de70cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748099569"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

