module 0xbc19d6225827cadfdb78d44e585b1036d7a79111ff28a17efd4b08dda8a8c1cf::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/bbf74049-1e9d-4eef-a90c-1861f6c42826")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d51359791378f1655cf816b67514e27ca603d0dcab707e37ef448825e48b5b3698f84edcfcab88faeb6cfffa1e49388ec65b9a52827c93c319da8f27be67db09f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738838162"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

