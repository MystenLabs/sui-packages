module 0xe602f550b416ecd0b1cec88254bd20d08d65a15a86eb0c89b38f47c73ab256cc::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"Pug Coin Sui", b"Pug isn't just a cool dog on sui network, he's a bridge between tradition and the future of digital culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibmgrlpfoyyqn63lym3b5sxagvdn4ctd424xfjr6zyzsxcloxz24u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

