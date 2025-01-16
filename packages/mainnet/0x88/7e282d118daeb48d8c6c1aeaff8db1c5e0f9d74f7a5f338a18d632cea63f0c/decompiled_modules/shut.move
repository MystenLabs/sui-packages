module 0x887e282d118daeb48d8c6c1aeaff8db1c5e0f9d74f7a5f338a18d632cea63f0c::shut {
    struct SHUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SHUT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SHUT>(arg0, b"SHUT", b"Take my money", b"Shut up and take my money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/d09137d2-2e6d-414b-9cbc-5ad7405677d3")), b"https://en.wikipedia.org/wiki/Futurama", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0022e56ff4b5072ac769b34a3ca4426b2f8bae5387c94a6697b1dce5cd2374894db5b2a01c3d6bb76ad03d225e5e589f53335e8462f6b25acbeb51db24f9ab7205f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737018395"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

