module 0x808b828b37b7fbb5594bd941fc6aede78a073f8214c896c86a05f8f06273f6e8::v {
    struct V has drop {
        dummy_field: bool,
    }

    fun init(arg0: V, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<V>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<V>(arg0, b"V", b"Vendetta", b"*-*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYeHfPydmE5e9pwyEy32gtMU9ZJKCX9fK2aPUBNzSDLQZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003d8aa8f4e08058842ce145b9fcea068bcb8a67c37e9d8eef13b83596d46a32c97b0fa6cb820ec713fff4e74c083e3edc73d66319fe87e71d99a7c66a5e5b5509d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748080413"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

