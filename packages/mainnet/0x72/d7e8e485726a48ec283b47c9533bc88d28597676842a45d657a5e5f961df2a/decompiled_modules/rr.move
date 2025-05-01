module 0x72d7e8e485726a48ec283b47c9533bc88d28597676842a45d657a5e5f961df2a::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<RR>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<RR>(arg0, b"RR", b"LedgerX", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008cb4921669d335ec125223e4f1dba13bf02dd0a5bc953a582e7fe6f4b2d5299c7a01b829595ee54fd6d35b685ad7b58b7d4a4f6349ac311bc1fa5b992e94390ded4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746106537"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

