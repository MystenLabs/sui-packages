module 0xd0e19b9b0ac01b1356a3d7e6fa7660c1b23d08bf039b94a210e009fe2671a87::out {
    struct OUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<OUT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<OUT>(arg0, b"OUT", b"outside air", b"outside air2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/44609428-7d82-41da-8a49-0ae3571b6cbd")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008ddea3371e3c43413a062d9993a9fdf2988a23e94b8aa1bb6ab3e715d059260893d2ce23f3136715868b623871592361ebbb7cad02f32b8566c148c3a553fb04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738572562"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

