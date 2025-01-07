module 0x40224ac4a173da8380f46e4b518c43a77b3b4d80cc95ca00fc16261da577d77f::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAPPY>(arg0, 6, b"FLAPPY", b"Flappy The Bat", b"Presenting the character that Matt Furie Loves To Draw The Most!  Pepe May Be the most populaR, HoppY May Be The Most Acclaimed And Spike May be The first, But they are not Their Creator's favorite! That Distinction Belongs Solely To FLAPPY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_6186289d1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

