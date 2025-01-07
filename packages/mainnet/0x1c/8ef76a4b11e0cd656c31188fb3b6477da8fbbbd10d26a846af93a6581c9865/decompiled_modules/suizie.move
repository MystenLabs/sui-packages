module 0x1c8ef76a4b11e0cd656c31188fb3b6477da8fbbbd10d26a846af93a6581c9865::suizie {
    struct SUIZIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZIE>(arg0, 6, b"SUIZIE", b"SUIZIE on SUI", b"$SUIZIE brings a fun, energetic vibe to the Sui. With a lively personality, this token is all about joy, excitement, and making every moment in the Sui world a fun adventure. Jump into the world of $SUIZIE and enjoy the ride! Don't forget; if you make $SUIZIE happy, then he will make you the same way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIZIE_b9e98ddea9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

