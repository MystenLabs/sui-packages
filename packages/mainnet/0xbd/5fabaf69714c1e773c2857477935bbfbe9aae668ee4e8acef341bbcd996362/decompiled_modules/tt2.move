module 0xbd5fabaf69714c1e773c2857477935bbfbe9aae668ee4e8acef341bbcd996362::tt2 {
    struct TT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT2>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT2>(arg0, b"TT2", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006051d5d7f5938e11a066f75e8ac2347314a7f2a51ded566d658eb8988bb900aa87239fd7969f1e42989c9e45d42bd92d23255ac9175bb99c2cbf0b20b404850aed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746098182"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

