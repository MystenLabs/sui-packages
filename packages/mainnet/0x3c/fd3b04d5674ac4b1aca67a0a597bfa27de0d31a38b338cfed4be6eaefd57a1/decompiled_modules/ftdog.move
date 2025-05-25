module 0x3cfd3b04d5674ac4b1aca67a0a597bfa27de0d31a38b338cfed4be6eaefd57a1::ftdog {
    struct FTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FTDOG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FTDOG>(arg0, b"FTDOG", b"FUTDOG", b"It is a meme coin from future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8qrLQfW511muhQs1jqQYqiDSh5YLdYU129qsYUvpjAm")), b"www.futdog.com", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bc4967f9aa3230ad117cbd01a746e9b8fc4850eb18310e1851c77fa219d1f7ce2f9e3506a082dff974744e518993b395451bb04e1d5e13e6feecca8e5f317505d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748158351"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

