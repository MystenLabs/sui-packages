module 0x67c8981ae1a737604a866c738e3b8b7455a9cef27ce3e7d16c934dc0648c1137::scury {
    struct SCURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCURY>(arg0, 6, b"SCURY", b"SCURYDEEZ", b"ScurryDeez", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H8r_R_Wtv_Z_Fbdt_Wasqup_Rey_M9ue_S_Qxw6_FCQ_Buu_Aj_X_Spump_558453c222.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

