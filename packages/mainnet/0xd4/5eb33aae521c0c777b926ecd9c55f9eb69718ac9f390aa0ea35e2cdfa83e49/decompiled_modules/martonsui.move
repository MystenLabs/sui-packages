module 0xd45eb33aae521c0c777b926ecd9c55f9eb69718ac9f390aa0ea35e2cdfa83e49::martonsui {
    struct MARTONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MARTONSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MARTONSUI>(arg0, b"MARTONSUI", b"Marathon", b"Success is a marathon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTNGyNywPm8zJ4ikoeJHTfmYuxSLbCWmt1LC7QwtaNB7X")), b"https://x.com/Lordmarathonx?t=vxvm4d32ie8yUgsOYQhs4Q&s=09", b"TWITTER", b"DISCORD", b"https://t.me/decryptomanians", 0x1::string::utf8(b"00e1bb331e67d669a3bab2db8f3f59cc8452a3ad332c14509f804815019ae5efeacce4910b4d54b2fa7810a7a1792bfd42af1302037e9aeca226a5b3eb91824b01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748089167"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

