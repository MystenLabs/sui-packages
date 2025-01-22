module 0x468c114e59e51508680ded81ad6b78d0957b653b8fefc446468bd6ec8c4d01a1::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<EARTH>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<EARTH>(arg0, b"EARTH", b"Planet Earth", b"THE Planet Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/a7da1a1c-6876-4141-aedf-4a0259e67d55")), b"https://www.earth.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b1ed9ddb9f970968ead32ff5ee183ed96cc8d974dd6f2aae745f9318548da517c3a47b711a1b0c6ff00e4592fa83f84d8ec06ca263bd4bf8910d138d3598010ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737534574"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

