module 0x48b1464eab309bb39835f2ca91dc34a4cd49dfe5880817b53ab1f4ef32e8ef64::wwd {
    struct WWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<WWD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<WWD>(arg0, b"WWD", b"TEST7", b"Random token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009e14cf418b98c55a1e2b3cea47ec2dc6f9f6843159ccba986cf6abd351960aeeee1b726be20dd198bcfc69c22610208c6b5adbdab3704fec07d862895b1f6104aac7981e520fe4d608514382220b65e9590f2e7d4cb83c958c1c6ec69d6af9971743679624"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

