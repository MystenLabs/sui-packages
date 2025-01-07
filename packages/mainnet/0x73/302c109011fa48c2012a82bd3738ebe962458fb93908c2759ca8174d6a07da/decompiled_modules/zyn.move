module 0x73302c109011fa48c2012a82bd3738ebe962458fb93908c2759ca8174d6a07da::zyn {
    struct ZYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYN>(arg0, 6, b"Zyn", b"Zyn Coin", b"$ZYN brings the best part of upper deckys, onchain. ZynCoin has no shortage of good vibes as a fair launch, community led project that brings that buzz to your portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2120_f07e52f09b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

