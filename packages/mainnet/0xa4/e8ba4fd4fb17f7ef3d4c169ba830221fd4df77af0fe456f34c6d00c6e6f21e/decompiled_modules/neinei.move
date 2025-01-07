module 0xa4e8ba4fd4fb17f7ef3d4c169ba830221fd4df77af0fe456f34c6d00c6e6f21e::neinei {
    struct NEINEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEINEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEINEI>(arg0, 6, b"NEINEI", b"Nei Nei CTO", x"4e6569204e656920636f696e2069732061206672657368207477697374206f6e204e6569726f2c2074686520766972616c206e657720646f676520726563656e746c792061646f7074656420627920417473756b6f205361746f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEINEI_T_Ta8pj_sb2f_FZNJ_Mg_LW_1_32bf8471c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEINEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEINEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

