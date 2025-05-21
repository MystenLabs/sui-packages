module 0xbc62168221cd489f974281dc25fb19b3911d8d00820a52de0ebc5c9a9439bc84::pak {
    struct PAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PAK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PAK>(arg0, b"PAK", b"Markhor", b"Just a meme Coin on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRimZz8w7QX8fBgQSR14GSYT7vWN8j1EBFUqDBhN3fHpx")), b"WEBSITE", b"https://x.com/irambukhari_", b"DISCORD", b"http://t.me/r4jpoot", 0x1::string::utf8(b"00c21285df64f86ba55942ca9b12d08a268183957b76c08dae9d639ce7aa9a82e578bf6860697bea606801351ee42c7fb3e825fd8a8fdc724342eeeb8096162a04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747850931"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

