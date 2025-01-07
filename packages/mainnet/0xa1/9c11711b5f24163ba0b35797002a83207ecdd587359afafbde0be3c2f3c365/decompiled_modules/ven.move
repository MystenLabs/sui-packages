module 0xa19c11711b5f24163ba0b35797002a83207ecdd587359afafbde0be3c2f3c365::ven {
    struct VEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEN>(arg0, 6, b"VEN", b"VenSui", b"The Puppy, The Myth, The Legend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_19_14_49_57_A_close_up_of_a_cute_and_mystical_dog_standing_on_a_magical_floating_platform_The_dog_is_small_fluffy_and_adorable_with_shimmering_fur_that_softly_6aafac1ba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

