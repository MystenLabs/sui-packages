module 0xdc025ab878bf99d25863f45f70bc92cd760f4b51f1e995e516c95d2f2d2b7a80::azu {
    struct AZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<AZU>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<AZU>(arg0, b"AZU", b"AZURE", b"Azure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/8015afa8-e208-4e4e-9f48-f71701692939")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009d7788ef2e8becc2f9468cdc463563a03ab770bc959e75a13a4b269d68c1ede3678cc3d5672f56e8fb476e9fc6b493e8bc18fc75d1740da2a2dc7cc53f9f9706f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737637616"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

