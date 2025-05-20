module 0xe8fc3cc24237f20972f088ce4e84af4a27deab59b96ec3a38575c5016a21e432::spd {
    struct SPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPD>(arg0, b"SPD", b"splash dog", b"Offical splash symbol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQMjxmkWBwx13ao4M6niSKDTiYj3f7xisVirdYVr8oiRo")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007f53a1d417dcc37ca58225e56ed1df0da901f947d914a491a53a4288ab7df6750a396d405a6b48970944f893a19feee37b8e986a20b7efb709080aab95c72503d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756111"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

