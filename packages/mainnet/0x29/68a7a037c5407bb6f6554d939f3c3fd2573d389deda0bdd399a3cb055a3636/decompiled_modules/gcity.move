module 0x2968a7a037c5407bb6f6554d939f3c3fd2573d389deda0bdd399a3cb055a3636::gcity {
    struct GCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCITY>(arg0, 6, b"Gcity", b"G-city on sui", b"Congratulations on joining the party crowd! Let's have fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artbreeder_image_2025_01_14_T09_04_15_922_Z_731d411ff7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

