module 0x25d93c13f1995bf0907413866e8796ef7f5ca16678b6f7a5bab2f82d35378a05::shut {
    struct SHUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SHUT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SHUT>(arg0, b"Shut", b"Take my money", b"Shut up and take my money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/b5d756f6-0199-4210-8e6f-c978e5786eaa")), b"https://en.wikipedia.org/wiki/Futurama", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005356206d66c8f0272888bacc4a777def054774246bdcbe3cfc2df4e940e703d06ead1e506aa1a5547d6d4cf300f1dd8b05d405a46a745096fbc17a17fb00d501f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737018041"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

