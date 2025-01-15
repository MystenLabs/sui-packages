module 0x45c113857c11a75f61fede396c9b286680829f185e496915c5bd3c7027ca6d8e::cattest {
    struct CATTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<CATTEST>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<CATTEST>(arg0, b"CATTEST", b"CATTEST TOKEN", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/bcf7123f-0fd6-4c44-9e78-c27654eed2ac")), b"testcat.fun", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f5e316dc6e031e1f1f5068546335c2f33686b8a3b25889cbe17085e73a028cdb26329e59a6d0f9fde8486c4dccd34ddd8af6e095b8c448f50cd3a92077ca4b08f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736939385"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

