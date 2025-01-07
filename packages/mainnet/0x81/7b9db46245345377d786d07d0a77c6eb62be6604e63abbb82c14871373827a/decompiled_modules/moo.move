module 0x817b9db46245345377d786d07d0a77c6eb62be6604e63abbb82c14871373827a::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"MooMoo", b"MooMoo is a lighthearted meme coin dedicated to bringing joy while promoting the well-being of farm animals and supporting sustainable farming. A portion of all profits will fund awareness campaigns and charitable causes worldwide. Join the herd and be part of a fun, positive, and impactful community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F7980_F44_8929_4_CB_1_AB_56_8_E98171_B08_C5_a84ce1af8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

