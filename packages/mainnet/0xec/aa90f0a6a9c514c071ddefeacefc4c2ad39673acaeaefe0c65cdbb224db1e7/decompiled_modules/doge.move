module 0xecaa90f0a6a9c514c071ddefeacefc4c2ad39673acaeaefe0c65cdbb224db1e7::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<DOGE>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<DOGE>(arg0, b"DOGE", b"LiteDoge", b"New best dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/6274bcd8-e041-4904-bff0-055d519f364c")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007993fefaf7478809444c4d5911931586dd3ff7ab1537f03eac79c020f23cd67575f3c8a9fbb10bbdf4fb42b123c1fd667dcf13ae7ffea6e6657510f28ad72702f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737119331"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

