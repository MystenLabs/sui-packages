module 0x48fcacde0952afd518cf416d6b2c39d883b28b48c09500857a6d332b2ef61199::dmp {
    struct DMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMP>(arg0, 6, b"DMP", b"Dog go to moon project", b"We will list dex exchange. Now developing, My whale friens coming. BUY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_22_49_26_A_cute_dog_riding_a_rocket_on_its_way_to_the_moon_The_dog_is_wearing_a_small_astronaut_helmet_looking_excited_as_it_zooms_through_space_The_backgro_fda90ff3ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

