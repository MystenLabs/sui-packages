module 0xf830646c3332ef257b1a878c350f699ec04a662881f3f84c17ab579180e6d0c2::floppy {
    struct FLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPY>(arg0, 6, b"FLOPPY", b"Floppy the Hippo", b"Floppy the Hippo - An original character known as the whimsical fortune-teller with a chill vibe, Floppy offers unique insights and surreal humor to Sui Blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hb9_Ztj9_Rh1t_Q58z_F_Ti_Jai_J1wy_ALV_Ub_ZE_Nh8_QLXP_8pump_8911992a7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

