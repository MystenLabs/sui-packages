module 0x738e0490ecb4a9829f2966d4c145b20fdd58b23c1c792513b1dc31048198f92a::tkn {
    struct TKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TKN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TKN>(arg0, b"TKN", b"newToken", b"tok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/e605fb2a-01e9-4ce4-a1dc-d7a70a358093")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00527ce4076ade0258c20e32e0e4171bc9a3f60f2fbce5159ac8401a2b6e5125a4ab454b1b535e1ab0fefc62697982cf01e2f16494e4e0f2c3e07f038be1583306f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736846404"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

