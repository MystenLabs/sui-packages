module 0x309001834e13124a6ac394b19798019ceb9e4ba7d72f9743c080920ae4f77dd7::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAA>(arg0, 6, b"AAAAAA", b"SUPER AAAAA", b"SUPER AAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goku_super_saiyan_pictures_dm8zixw58guf3x1b_a55a693ef9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

