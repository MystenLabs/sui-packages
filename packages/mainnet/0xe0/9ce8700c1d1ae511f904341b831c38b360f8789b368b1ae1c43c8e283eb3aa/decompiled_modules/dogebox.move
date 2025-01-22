module 0xe09ce8700c1d1ae511f904341b831c38b360f8789b368b1ae1c43c8e283eb3aa::dogebox {
    struct DOGEBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEBOX>(arg0, 6, b"DOGEBOX", b"Dogebox", b"DOGEBOX is the ultimate memecoin that combines the fun of memes with the thrill of surprise! Inspired by the concept of mystery boxes, $DOGEBOX brings an element of excitement and unpredictability to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046173_7736cdb2a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

