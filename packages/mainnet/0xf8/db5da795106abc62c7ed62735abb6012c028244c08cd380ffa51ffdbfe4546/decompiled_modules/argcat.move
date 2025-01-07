module 0xf8db5da795106abc62c7ed62735abb6012c028244c08cd380ffa51ffdbfe4546::argcat {
    struct ARGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARGCAT>(arg0, 6, b"ARGCAT", b"Captain Whiskarrrrrz", b"Most cats be 'fraid o' water, but not ol' Captain Whiskarrrrrz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/619_Hh_G5_MELL_AC_UF_1000_1000_QL_80_7c7c4e897c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

