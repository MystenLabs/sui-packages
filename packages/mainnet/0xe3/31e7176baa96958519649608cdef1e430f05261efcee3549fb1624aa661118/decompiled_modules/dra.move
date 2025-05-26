module 0xe331e7176baa96958519649608cdef1e430f05261efcee3549fb1624aa661118::dra {
    struct DRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRA>(arg0, b"Dra", b"draco", b"token of great luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmca95p2dpzcxxgdogfHLCxZdbn88PDD65K3k3mZpCbfFt")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a6432bc0f1f6bac05973f44247a857cc8d18fd0c9df515838a7564ca08d178d8e28643420c059e1188cede4dadc3ecaae284ca26ca1c1bfec1d6bb1d79c00104d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748273929"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

