module 0x1df461189a4f398a935ced88a85ad73b8122d48ea180b67d7a62d076f02ff59::mechu {
    struct MECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECHU>(arg0, 6, b"MECHU", b"MEMECHU", b"Born from radioactive shitpost and thunderstrom. here to electrify the chain. No promises, just raw meme energy buzzing through the SUI universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieq3ortdnsei6cbwhrdtosy3uqkex3zjraz4ingpn3m4klth5x45u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

