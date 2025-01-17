module 0xf11a08a8bb8713af25453f2139c1997ccf50c151887fa4dd788e1b71481a2563::ast {
    struct AST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<AST>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<AST>(arg0, b"AST", b"Astronaut", b"Astronaut in space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/4032104f-eddc-4ef0-8442-28b71c7aa46e")), b"https://www.spacex.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b0129df201455986ca77cab3fb8e9ab1515164184b00f08fec72f835b63a3abd60c5775e548600c77f8883b38fbd3bb0d2d713e28f54ce81b783a1e7d2047305f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737137146"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

