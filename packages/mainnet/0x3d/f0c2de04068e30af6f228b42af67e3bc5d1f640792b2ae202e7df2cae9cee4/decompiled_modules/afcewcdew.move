module 0x3df0c2de04068e30af6f228b42af67e3bc5d1f640792b2ae202e7df2cae9cee4::afcewcdew {
    struct AFCEWCDEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFCEWCDEW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<AFCEWCDEW>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<AFCEWCDEW>(arg0, b"Afcewcdew", b"fdadsadas", b"dcascwecwecew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmamzAH929HxAo8tSn791gEZxHx2R9RgXav2uFBPcRJJNj")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005e4745d539436305a001b45a394564ecd03dd7b49b7610690d5a303049932482e8f4ae8e762609bf3a305c25336dae496cc4c4958bfaacb8d5a098a41fde2605ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746104925"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

