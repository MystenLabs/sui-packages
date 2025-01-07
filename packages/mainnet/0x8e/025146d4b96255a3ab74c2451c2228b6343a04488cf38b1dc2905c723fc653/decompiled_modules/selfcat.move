module 0x8e025146d4b96255a3ab74c2451c2228b6343a04488cf38b1dc2905c723fc653::selfcat {
    struct SELFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFCAT>(arg0, 6, b"SELFCAT", b"SELFCAT ON SUI", b"selfiecat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_28_19_06_23_removebg_preview_e01f2818ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

