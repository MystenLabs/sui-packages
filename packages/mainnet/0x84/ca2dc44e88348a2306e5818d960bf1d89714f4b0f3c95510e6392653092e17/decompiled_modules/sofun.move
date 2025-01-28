module 0x84ca2dc44e88348a2306e5818d960bf1d89714f4b0f3c95510e6392653092e17::sofun {
    struct SOFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SOFUN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SOFUN>(arg0, b"SOFUN", b"SoFun", b"It's so fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/0c431224-bb45-484d-82c1-0096d4741441")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005fb7d1fed6b0f1442342689841ff583ee012e86a77561e056e5e7f61dd0814da481be19d0306aabf1c1292601717af7103f3d4f9550ba000d780684107665903f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738059270"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

