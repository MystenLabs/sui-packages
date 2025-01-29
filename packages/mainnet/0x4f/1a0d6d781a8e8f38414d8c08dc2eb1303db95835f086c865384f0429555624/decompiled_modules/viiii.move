module 0x4f1a0d6d781a8e8f38414d8c08dc2eb1303db95835f086c865384f0429555624::viiii {
    struct VIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIIII, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<VIIII>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<VIIII>(arg0, b"VIIII", b"VIBEEE", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/4e89491c-4bb2-43b8-9076-820e22cc7a00")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0031e2fc782ffb595316a3320685db8b5e6daf5564f63b445158c6e239c7aea88b5cd82c744b299d0ec6eba4658a68c8239a3e1896cfbc138c7e561539daa9b50af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738166366"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

