module 0xa2f25b9c1a398f2734b6e6b4a58008168cd80c61d81d5c0294fe4ef5b1043d53::moonzali {
    struct MOONZALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONZALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONZALI>(arg0, 6, b"MOONZALI", b"MOONBARAK GHOZALI CTO", b"Meme Officer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpxot3tkhxdhkjofgsuctrbxzznkmtwkrq4lfqxqf7jcqq24wrgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONZALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONZALI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

