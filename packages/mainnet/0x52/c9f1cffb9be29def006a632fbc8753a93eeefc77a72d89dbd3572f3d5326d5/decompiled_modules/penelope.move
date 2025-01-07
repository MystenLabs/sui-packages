module 0x52c9f1cffb9be29def006a632fbc8753a93eeefc77a72d89dbd3572f3d5326d5::penelope {
    struct PENELOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENELOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENELOPE>(arg0, 6, b"PENELOPE", b"penelope", b"aaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/man_doing_dumbbell_flat_bench_press_chest_exercise_flat_illustration_isolated_on_white_background_free_vector_removebg_preview_1_cd043a0585.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENELOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENELOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

