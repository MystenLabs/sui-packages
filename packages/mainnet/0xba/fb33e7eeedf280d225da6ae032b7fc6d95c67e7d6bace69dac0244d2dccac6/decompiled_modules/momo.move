module 0xbafb33e7eeedf280d225da6ae032b7fc6d95c67e7d6bace69dac0244d2dccac6::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<MOMO>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<MOMO>(arg0, b"Momo", b"momo", b"momo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/25eaa05c-7aea-4adc-9582-423c7da1aba5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b493a981511bc715220fb0fe1a61219e6d9f214bc2c15da93271c8d4b8a658260a105eb36bc9696c27a9a3c4a6cdb15fbbfc96e48a928299a95e3d8863f87b08f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736932085"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

