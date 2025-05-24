module 0x1df13d2147249f032548a829db662b723b202326db6799159ad58cba2214a752::pasccan {
    struct PASCCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASCCAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PASCCAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PASCCAN>(arg0, b"PASCCAN", b"pascan", b"pascan1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdjyzXxvic8yumfHiWvoX4ZtVKXotPuSjq3Lmq9BPSPic")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00adc4028d5284639cc760f83c170594d12856e8fa72c5472363ebf6797725624a6e5100c4cd1757941a5b71af7cc669ceed6c23796333ef7792441178fb12b80bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748082451"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

