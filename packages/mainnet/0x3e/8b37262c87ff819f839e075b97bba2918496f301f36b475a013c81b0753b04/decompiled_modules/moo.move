module 0x3e8b37262c87ff819f839e075b97bba2918496f301f36b475a013c81b0753b04::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"MooMoo", b" joy while promoting the well-being of farm animals and supporting sustainable farming. A portion of all profits will fund awareness campaigns and charitable causes worldwide. Join the herd and be part of a fun, positive, and impactful community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F7980_F44_8929_4_CB_1_AB_56_8_E98171_B08_C5_d853203775.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

