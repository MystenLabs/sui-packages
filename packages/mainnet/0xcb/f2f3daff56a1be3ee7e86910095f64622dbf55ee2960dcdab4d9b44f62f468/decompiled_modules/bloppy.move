module 0xcbf2f3daff56a1be3ee7e86910095f64622dbf55ee2960dcdab4d9b44f62f468::bloppy {
    struct BLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOPPY>(arg0, 6, b"BLOPPY", b"BabyLOPPY", b"We can do it because we are cute!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zl_SZ_Fga_AAA_Nx_Sp_1973d8ae3e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

