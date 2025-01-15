module 0x48ae140e2ad77b6dcdd366247a97de8db7e9ade7fa80a8432a917a810bcc3527::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<MAN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<MAN>(arg0, b"MAN", b"Tired Man", b"Tired -_- Man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/5d51df30-35c7-4544-a415-30cf606c5849")), b"https://www.spa.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00649315f8d47b52f732a6d49676eb81f16fb3c877b44ac51cffbca282e8e42236365ea91f8842705eb259db618db13eb7a12ebcbf55830d5c80db915efd3a720cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736974771"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

