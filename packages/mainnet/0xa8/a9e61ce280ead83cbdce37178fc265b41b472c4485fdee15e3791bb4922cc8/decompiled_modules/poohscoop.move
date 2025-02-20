module 0xa8a9e61ce280ead83cbdce37178fc265b41b472c4485fdee15e3791bb4922cc8::poohscoop {
    struct POOHSCOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOHSCOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOHSCOOP>(arg0, 6, b"POOHSCOOP", b"Pooh $coopin", b"The dog that scoops all the $hit you leave behind and enjoys it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_02_19_20_23_31_Create_a_cartoon_character_of_a_dog_using_a_poop_scooper_The_dog_should_have_a_fun_expressive_face_and_be_depicted_in_a_humorous_and_playful_manner_d55e1b13c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOHSCOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOHSCOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

