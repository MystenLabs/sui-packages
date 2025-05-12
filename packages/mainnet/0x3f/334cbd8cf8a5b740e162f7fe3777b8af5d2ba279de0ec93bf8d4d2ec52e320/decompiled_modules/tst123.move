module 0x3f334cbd8cf8a5b740e162f7fe3777b8af5d2ba279de0ec93bf8d4d2ec52e320::tst123 {
    struct TST123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST123, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TST123>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TST123>(arg0, b"TST123", b"test 123", b"test 12.05", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d9d8f6dc020a5154abe1d65fcb44fe4821a46b48c56f715b6a552fa60a692db8b3be8466e26aa57f43a02ad3759989f6d8d957c4fb8a5ed0dc981ea809e5f409ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747053137"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

