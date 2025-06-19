module 0x4195b86f780b917de421490f05d380bf59fa33c4bd1583ea34e5ef6a9994d6e7::suino {
    struct SUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO>(arg0, 6, b"SUIno", b"Suino", b"The piggiest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_j_tkqcj_N_1750356746741_raw_49df5f1749.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

