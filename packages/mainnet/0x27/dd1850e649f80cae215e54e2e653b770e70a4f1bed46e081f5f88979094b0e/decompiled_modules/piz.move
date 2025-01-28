module 0x27dd1850e649f80cae215e54e2e653b770e70a4f1bed46e081f5f88979094b0e::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<PIZ>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<PIZ>(arg0, b"Piz", b"PIZZA", b"THE Pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/83d09448-dce7-43d1-9929-a64014595682")), b"https://pizza.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0095024c4fbe535b4680d799c04d17a203763167deed01979b475fd0e638c82df1234d421498f7019934d727c316e5320a0c9a496e8041fa64a4725b0d35ad4e08f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738056774"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

