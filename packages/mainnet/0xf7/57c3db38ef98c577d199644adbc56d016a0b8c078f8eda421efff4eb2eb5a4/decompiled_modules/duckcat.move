module 0xf757c3db38ef98c577d199644adbc56d016a0b8c078f8eda421efff4eb2eb5a4::duckcat {
    struct DUCKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKCAT>(arg0, 6, b"DuckCat", b"DuckCatSUI", b"a DUCK and  a  CAT  on  SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_Do_Rjgb_EAEMI_1_B_8114917d13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

