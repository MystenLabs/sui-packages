module 0xf0c7a8087477238c65effe3a9a2c56f0d8e4013e0cee079f38ac40e32aa8f1d6::faketaxi {
    struct FAKETAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKETAXI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<FAKETAXI>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<FAKETAXI>(arg0, b"FAKETAXI", b"FakeTaxi", b"Fake fake taxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/a33416b9-2915-4ebd-a424-a7648098d890")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a9d5288958000499a3fbee8a7fc3d2bb74a35fefa2753c11b49a6472a6228016bb51a5422c1d3809cefb855e1218326ee73da81282eded3e1e467a32fc662608f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737666041"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

