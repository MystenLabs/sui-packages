module 0x1d18f794ab94435d75329bd10cece029e49a4da896c13e153f9c57395b692a66::dumbfi {
    struct DUMBFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBFI>(arg0, 6, b"DUMBFI", b"DUMB FISH", b"The Dumbest Fish On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_19_at_11_01_22_AM_732167c78c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

