module 0x9389b72a7b7833865e9c07f68bcb5fef7869951ec5fcd4b7744af5e639b70a0e::selfiecat {
    struct SELFIECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIECAT>(arg0, 6, b"SELFIECAT", b"SELFIE CAT", b"Welcome to SELFIE CAT. The most photogenic CAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_00_55_01_883ff0eb5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

