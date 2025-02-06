module 0xbaeef77d0fa4e757930f6590f74d079d103ea656e4def74547bd4f9fd5fb46ba::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SUN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SUN>(arg0, b"Sun", b"White Sun", b"White Sun nova", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/4f7151c5-41d1-4ca0-8ff7-867f18a299ad")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f0110a328f3c1433d51cec388bb720b82923d703eba6cda8da60dd10d8fc3412fa81a0afaf2bb1d2918ca14c85193184bb7cf133858720aed4d2c0ff1271d206f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738835749"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

