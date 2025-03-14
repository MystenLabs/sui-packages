module 0xec269892f1dffe846bfadb0286e38661a909f635dea1fd7bc84c0cdfc85bc630::smo {
    struct SMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMO>(arg0, 6, b"SMO", b"Simo", b"Simo's token,don't buy!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_29_14_27_47_A_digital_pet_with_a_whimsical_and_artistic_vibe_combining_elements_of_nature_and_fantasy_The_pet_is_shown_from_a_front_facing_view_with_expressive_84058f3ee5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

