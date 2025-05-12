module 0x3b2aa5e510b6ae30ccdd2fc0c58741c80be7e1bc5349ff16060e6cb876cb0aed::este {
    struct ESTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<ESTE>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<ESTE>(arg0, b"ESTE", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00106ffb63ca965b85ec44189228b0387f2c06394378b8c0fcac55eb7631d535e83b4d0e741b8c9215f5a831757c24527e6580121ab09e7832a3e1e97f84279906ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747069756"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

