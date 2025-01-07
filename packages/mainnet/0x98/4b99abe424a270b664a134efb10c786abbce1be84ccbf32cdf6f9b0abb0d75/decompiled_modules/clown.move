module 0x984b99abe424a270b664a134efb10c786abbce1be84ccbf32cdf6f9b0abb0d75::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWN>(arg0, 6, b"CLOWN", b"Clown Paul", b"Meet the $CLOWN of boxing. Jake paul. The ultimate meme coin to roast Jake Paul as he steps into the ring against Iron Mike Tyson. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_95_5124d5ecec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

