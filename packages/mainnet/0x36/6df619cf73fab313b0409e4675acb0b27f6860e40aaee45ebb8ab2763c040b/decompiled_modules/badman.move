module 0x366df619cf73fab313b0409e4675acb0b27f6860e40aaee45ebb8ab2763c040b::badman {
    struct BADMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADMAN>(arg0, 6, b"BADMAN", b"Sui Badman", b"Badman is on a mission to unite creatives and OGs, fueling art, memes, and mayhem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015100_5513f75d6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

