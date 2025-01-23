module 0x72454c366fa6e2395dca0df0dab4c381b490b6bd5143b2d0e5813d8575fac615::ergy {
    struct ERGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<ERGY>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<ERGY>(arg0, b"ERGY", b"ENERGY", b"ELECTRIC ENERGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/983d6713-e744-4b36-8dfd-948f135d69b8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e1bf879f4a7fb1c4f75632fb01038d1b488c9c4a130fb5a713dce1291b29d6acc0aa576f9ddbfa13f0a80123e3bd1a7cb06f6417d212f26134538d4a04fde509f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737637385"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

