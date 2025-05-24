module 0x791f1e1bb7c54166686871116e1c832e68bf1c2b6dca9e9dd31f8031fd6d482c::martonsui {
    struct MARTONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MARTONSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MARTONSUI>(arg0, b"MARTONSUI", b"Marathon", b"Success is a marathon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTNGyNywPm8zJ4ikoeJHTfmYuxSLbCWmt1LC7QwtaNB7X")), b"https://x.com/Lordmarathonx?t=vxvm4d32ie8yUgsOYQhs4Q&s=09", b"TWITTER", b"DISCORD", b"https://t.me/decryptomanians", 0x1::string::utf8(b"008bfcc84a62594a23c49073667f7f110888cde6e90612ef33a9958b287586278580b612da97dad0c567775b13846009b344b04f127bf05c62c10af6d21fff1503d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748089995"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

