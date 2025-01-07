module 0x7caf3ca0f710fe752d66b08044e643e6c4e0332ec3313a70bb1bec8508ac3f1f::suimosa {
    struct SUIMOSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOSA>(arg0, 6, b"SUIMOSA", b"Suimosa", b"Just a SUIMOSA !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_13_41_23_a3118673eb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

