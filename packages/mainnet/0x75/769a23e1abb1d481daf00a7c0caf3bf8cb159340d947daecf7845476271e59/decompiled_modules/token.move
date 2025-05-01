module 0x75769a23e1abb1d481daf00a7c0caf3bf8cb159340d947daecf7845476271e59::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TOKEN>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TOKEN>(arg0, b"Token", b"Test", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f56ff78f28779bc95a57849e59216458e4101a3320cb472c5e3e62252188f81ef505852e186de5784b0a0307470f67a026e696b4af313938c35ebb0e354a7b0bed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746098014"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

