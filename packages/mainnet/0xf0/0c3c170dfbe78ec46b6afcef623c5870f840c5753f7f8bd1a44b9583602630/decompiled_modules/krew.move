module 0xf00c3c170dfbe78ec46b6afcef623c5870f840c5753f7f8bd1a44b9583602630::krew {
    struct KREW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KREW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<KREW>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<KREW>(arg0, b"KREW", b"GTXPR", b"GTXPR. KREW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQDtS7VrpQyWAzYH254vJpkeebmeZavFbjCHEWcGb9EJe")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005d44b7074e5053df22905bd56cc2a3a9f106ea82768eb6f752d63d3e1430af75127f0843f94a0d547b8419510ace531d47d8694d542cd5892733f55adbbcb005f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745582499"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

