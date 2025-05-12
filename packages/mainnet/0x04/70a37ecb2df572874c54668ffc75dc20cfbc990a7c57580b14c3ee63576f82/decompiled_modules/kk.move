module 0x470a37ecb2df572874c54668ffc75dc20cfbc990a7c57580b14c3ee63576f82::kk {
    struct KK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<KK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<KK>(arg0, b"KK", b"KL", b"DS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bcc64b4106fff2f6c5be7af94dd713a90f57a66410e9313aa6cf548211be8b1d1496189a3f94b3492accd1271add7d75abbb404cab365d64d427c3b9d7739505ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747082152"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

