module 0x2bb778e259338585ff87768ec601c31bb9512806ff5456552ef7310fc01a23cb::argcat {
    struct ARGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARGCAT>(arg0, 6, b"ARGCAT", b"Captain Whiskarrrrrz", b"Most cats be 'fraid o' water, but not ol' Captain Whiskarrrrrz.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/619_Hh_G5_MELL_AC_UF_1000_1000_QL_80_7c7c4e897c_675a5088b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

