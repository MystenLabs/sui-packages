module 0x58aadb61691ea1c9994f0114f270a9ab5163a7e349ab75494517914427f6ea14::SingedAntennae {
    struct SINGEDANTENNAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGEDANTENNAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGEDANTENNAE>(arg0, 0, b"COS", b"Singed Antennae", b"Broken from a coil around gates long raised... long fallen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Singed_Antennae.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGEDANTENNAE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGEDANTENNAE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

