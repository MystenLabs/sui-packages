module 0x1c1fa57e38a6982c80dc9a10c89fed7e62aeb4c07ffcad841aef8ef1ddf2d41d::evr {
    struct EVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<EVR>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<EVR>(arg0, b"EVR", b"EVROPA", b"EVROPA1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/7ac3538e-c181-4ecc-8d6d-3b542d126919")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007eaed5e94303c658dfd3939df2d01d7bbe87b97a8664a1c0036246b494920cbf3b640773042d9ef8929a2e52a1aef3c40dc8887667b766d0d2d8eb2b0b49330bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738758295"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

