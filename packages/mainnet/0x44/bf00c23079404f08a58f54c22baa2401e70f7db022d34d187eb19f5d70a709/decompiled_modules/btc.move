module 0x44bf00c23079404f08a58f54c22baa2401e70f7db022d34d187eb19f5d70a709::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BTC>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BTC>(arg0, b"BTC", b"BEST TOKEN", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/a779d473-84bd-4804-badc-7bf5702d629f")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e5caeff04cb25293201986329dffb1534b5414fb29ed37518f3f3a265faa8a1e8d4ff125e58ed683a0fe772ac430f07b082aedbdea00c2303233f04bf52dd804f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739110796"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

