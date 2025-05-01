module 0x85bf4e9ac9facb3e60e33bfc27ece386fc1c444621b6e2cb0099af65bdb20791::tt3 {
    struct TT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT3>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT3>(arg0, b"TT3", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002fa37e97d274d1fdd6c15b5cef9c178ee305e2c91974f5bcb1b723d4abc33b9b01e7a87aa4ccf0b408d7f97852ac5724a51d8b92121b6338740e9483c09c3200ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746098567"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

