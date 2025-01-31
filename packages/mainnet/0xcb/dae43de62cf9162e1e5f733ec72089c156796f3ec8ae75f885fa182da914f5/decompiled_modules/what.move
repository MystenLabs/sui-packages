module 0xcbdae43de62cf9162e1e5f733ec72089c156796f3ec8ae75f885fa182da914f5::what {
    struct WHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHAT>(arg0, 9, b"WHAT", b"What if we all held", b"$WHAT  A meme, a movement, and the ultimate HODL experiment. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNpFHvvYWcTQXCStvVqVF2n4YYMBwe2z8J1XBdBmxiEHp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

