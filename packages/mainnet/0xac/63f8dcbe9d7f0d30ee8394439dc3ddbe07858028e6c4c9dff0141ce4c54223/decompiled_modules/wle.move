module 0xac63f8dcbe9d7f0d30ee8394439dc3ddbe07858028e6c4c9dff0141ce4c54223::wle {
    struct WLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WLE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WLE>(arg0, b"WLE", b"WLEWLE", b"WLEWLE FOR TAUNTING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ1U1dZGbGrYy6QKS2eH5sEed3pACKaE9xchzkvZLmAmt")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002f64d86e73094cdefbc1f34459bca5266c1f413ae057703e14979e1534bbd9f2e898df90fd927de638fa10b0509a78763605d53acd19da8a7c6d4bea5fd2080ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748269158"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

