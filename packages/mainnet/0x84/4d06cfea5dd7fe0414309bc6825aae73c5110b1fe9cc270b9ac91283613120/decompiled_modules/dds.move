module 0x844d06cfea5dd7fe0414309bc6825aae73c5110b1fe9cc270b9ac91283613120::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DDS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DDS>(arg0, b"DDS", b"DOGS", b"BIG SUI DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaZmAUi14TPBo3MUAeWp9EkLSCYAeqYpZiCpPYRAQGn41")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0051b032bb1e6270091a69afeec3f8c63dde91312f6bbebb8852f26d8dfc2d060a90dcfcd7e9100acc1c48a7c376e53c74dd2278544dd8720a0b7888b789da1f00f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631742293595"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

