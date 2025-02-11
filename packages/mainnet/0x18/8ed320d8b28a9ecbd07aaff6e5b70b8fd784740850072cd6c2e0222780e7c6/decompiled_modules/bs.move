module 0x188ed320d8b28a9ecbd07aaff6e5b70b8fd784740850072cd6c2e0222780e7c6::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BS>(arg0, b"BS", b"Base", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/570d20ba-a5d0-4fc6-b4cf-cea8da0545fa")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ae346c691015858c0e0227d685df371e6e9afbc2e589898551ab7c10e576d4021aae93cb62af891863967b72b42587d951b304591cffbf9eb05a0af260fa5803f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739278886"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

