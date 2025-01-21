module 0x9946cdc3947ec36589f6206e0cc9aa0b42db9331cbbe7c06c6e72bdbfe6b5140::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"TRUMP", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/21c9337e-7288-4cfc-a9c5-392da43860f3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a3103d760f9e6f26ba1881ba1a8a2fc89961681ce23745630c8697f993172ad1f76680ec0c901e1294bea9b598046df4dc7d5e9ca763ebcbe615e7694df5ea04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737459235"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

