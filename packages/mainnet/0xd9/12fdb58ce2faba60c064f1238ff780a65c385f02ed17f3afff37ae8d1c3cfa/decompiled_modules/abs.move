module 0xd912fdb58ce2faba60c064f1238ff780a65c385f02ed17f3afff37ae8d1c3cfa::abs {
    struct ABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<ABS>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<ABS>(arg0, b"ABS", b"Abstraction", b"Abstraction in life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/b085241f-30d6-4856-b882-58455c4cd143")), b"https://science.nasa.gov/", b"https://x.com/ExtremeDoor", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0006e778a7c76db1f03cf21cadd66c92efcb54c47efa06bd55863566526439335793b1fa163e7088d1aaf5b9ee86edd0c767fb706cf2b32c004449f56fa83f0207f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737193562"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

