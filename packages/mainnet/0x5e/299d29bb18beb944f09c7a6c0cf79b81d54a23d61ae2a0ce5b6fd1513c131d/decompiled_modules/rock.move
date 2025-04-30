module 0x5e299d29bb18beb944f09c7a6c0cf79b81d54a23d61ae2a0ce5b6fd1513c131d::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<ROCK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<ROCK>(arg0, b"ROCK", b"TO THE MARS", b"TO THE SSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"https://www.spacex.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c06983530b02696e5cfda05c347b1fb3b5768ae3279e4f36d51d87d43a02ac6acd878240ecd5f5875a2ff7e00dbf7102e7548bbe13ce6403db133b7b7b07360eed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746029304"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

