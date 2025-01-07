module 0x5a293d86939b5cb0a97b714744b9bdd2d8c8a7e10650345ff0289216a00b3bf3::saped {
    struct SAPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPED>(arg0, 6, b"SAPED", b"SUI APED", x"43796d62616c2d636c617070696e672c2062616e616e612d63686f6d70696e672c2063727970746f206e696768746d617265207772617070656420696e206a6f6c6c79206d6f6e6b6579206368616f73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_68_ac5666cfa3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPED>>(v1);
    }

    // decompiled from Move bytecode v6
}

