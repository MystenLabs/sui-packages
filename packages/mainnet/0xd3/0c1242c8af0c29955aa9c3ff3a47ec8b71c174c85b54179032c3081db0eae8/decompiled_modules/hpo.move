module 0xd30c1242c8af0c29955aa9c3ff3a47ec8b71c174c85b54179032c3081db0eae8::hpo {
    struct HPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<HPO>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<HPO>(arg0, b"HPO", b"Hi", b"Test best token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/af2193c7-efd0-47be-a02f-ca095e436dc5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cecc9647cb0b883349b8eb54555108e364539cbc85c793f48b79c30af9b5fdcaf9735dffeffe972f9fc496f0771545db2b083b958fab81c8478f6fa7e1f2130ef5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736856295"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

