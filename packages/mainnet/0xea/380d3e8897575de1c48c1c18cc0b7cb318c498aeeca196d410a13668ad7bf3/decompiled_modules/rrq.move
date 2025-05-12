module 0xea380d3e8897575de1c48c1c18cc0b7cb318c498aeeca196d410a13668ad7bf3::rrq {
    struct RRQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<RRQ>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<RRQ>(arg0, b"RRQ", b"Token", b"DEsc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0043309229f053f6d3b6f9c5832af0586a64cc82cc4d98cdab8826f36c290110088011602c519f1f81ea0cd0814559bb8b054b8f905c6751de95db235f566be00ded4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747071178"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

