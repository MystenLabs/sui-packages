module 0x37a98a7d762757b17087278442d7045c0e7143d222b97c75bf705473abb38fa0::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Catfish", b"Dive into the fun and quirky world of $FISH, the meme coin that's making waves on the SUI blockchain! $FISH isn't just another coin; it's a playful token that brings a splash of humor to your crypto portfolio. With its whimsical Catfish mascot, $FISH aims to entertain and engage, offering a light-hearted approach to the often serious world of cryptocurrency. Whether you're in it for the laughs or looking for a unique token to diversify your holdings, $FISH is here to make your crypto journey more enjoyable. Join the school, and let's see how far this Catfish can swim!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2e2ef22d7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

