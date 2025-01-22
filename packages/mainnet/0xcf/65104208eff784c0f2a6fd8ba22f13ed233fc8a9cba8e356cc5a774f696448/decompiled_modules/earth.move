module 0xcf65104208eff784c0f2a6fd8ba22f13ed233fc8a9cba8e356cc5a774f696448::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<EARTH>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<EARTH>(arg0, b"EARTH", b"Planet Earth", b"THE Planet Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/8cf49f90-d6f1-428c-9632-e80165605349")), b"https://www.earth.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00baf796b83594313a6208d347311602fd515c1ee086cb53a4c48f1dbcfcf9cd13c19eb2af2e6ae6d6d2d7d9ff27139e2dc1a149e93001506299dafbc6e13ae100f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737534897"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

