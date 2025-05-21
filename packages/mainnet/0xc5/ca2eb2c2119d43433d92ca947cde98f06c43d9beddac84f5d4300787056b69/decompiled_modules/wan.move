module 0xc5ca2eb2c2119d43433d92ca947cde98f06c43d9beddac84f5d4300787056b69::wan {
    struct WAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WAN>(arg0, b"WAN", b"Wansui", b"Fair-launch platform built on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQipN5VoX1jGxZMgjuzfG5J9qPJXkeE1HR1U9ZsuRXsrb")), b"https://wansui.fun/", b"https://x.com/wansuifun", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008646e30e5a8654a2092dd2389b3f2c5b9c80dbaaf25875ac72f2aa715d59a43ff987691a790b3c163128c87d856293c025a36b54638aa55b4a59d414b43ff905d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747833722"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

