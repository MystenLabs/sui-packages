module 0x491d3a20804d11862fcdc6aeb4e8e21061ce6a2b0271c72b1fcdc5399dcecaa8::bubblegum {
    struct BUBBLEGUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLEGUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLEGUM>(arg0, 6, b"BUBBLEGUM", b"Princess Bubblegum", b"Meet Princess Bubblegum, the pinkest princess in the world! Now she learns the ways of blockchain, striving to build his own legacy with $BUBBLEGUM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_032137_605_45d4e50903.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLEGUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLEGUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

