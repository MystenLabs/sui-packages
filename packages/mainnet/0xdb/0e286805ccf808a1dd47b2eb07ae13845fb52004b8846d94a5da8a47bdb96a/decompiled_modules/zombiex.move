module 0xdb0e286805ccf808a1dd47b2eb07ae13845fb52004b8846d94a5da8a47bdb96a::zombiex {
    struct ZOMBIEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIEX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ZOMBIEX>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ZOMBIEX>(arg0, b"Zombiex", b"Zombie", b"Hsha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPYJVP9cQiEAfUVntXQhcw6UddQoTHmQ4sziYNM2AcFch")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00285b22df5cbf7822a696b1dbd4569b10dc6f42b3bd1e0911165d869dc96877ea5af235598ad52f933c903a7fb8ef6453d477aa3fecd0fe39f533b54b4972aa0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758969"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

