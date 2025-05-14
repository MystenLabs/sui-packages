module 0xf753c7c78740de8598db7288d58c30479b79fc970030024ba79db7afcf76c92b::riri {
    struct RIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIRI>(arg0, 6, b"RIRI", b"RIRI COIN", b"RIRI is ready to f@ck you up and anyone who gets in his way. Join him or be dead.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjnspbz7g5t2a4pbwnmzsbl7wmrppkfktbrfdpw72vgbncvgqrpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIRI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

