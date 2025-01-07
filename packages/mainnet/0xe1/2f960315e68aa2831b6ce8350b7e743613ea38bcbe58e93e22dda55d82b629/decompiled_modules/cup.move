module 0xe12f960315e68aa2831b6ce8350b7e743613ea38bcbe58e93e22dda55d82b629::cup {
    struct CUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUP>(arg0, 6, b"CUP", b"America's Cup", b"Louis Vuitton America's Cup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Qsfn_R_By_400x400_c43adef480.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

