module 0x1a792329f612175f0c8c3b0d2b7372011e609e24103134b53d780f3159633f4e::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"Sui Punch Man", x"4d656574205375692050756e6368204d616e2e202453484954414d412e2054686174206f6e652050756e63682e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GEJB_Dpevef_DW_Vzy_H_Uzmebpiqr_Hw_Fehy5hq_T_Db_VGCL_7b_E_232ed6fe35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

