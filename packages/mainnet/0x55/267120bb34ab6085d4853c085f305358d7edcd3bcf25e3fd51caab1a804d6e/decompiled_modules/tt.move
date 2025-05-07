module 0x55267120bb34ab6085d4853c085f305358d7edcd3bcf25e3fd51caab1a804d6e::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"LedgerX", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"https://www.youtube.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cac49803e53b64991bb6ddd28ca4531a88dabab03b62440525cdf7b4f2c64dd0049e9978b60027e81a98ff5ae19c746b56e4fe05c7a8aa06aef5e095ad836107ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746624410"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

