module 0xdddf6f81af231afdd2d506118ea33cfc4fa008eec040a757769a49462d720470::mtrump {
    struct MTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTRUMP>(arg0, 6, b"MTRUMP", b"TRUMP MAGNET", b"The GOAT with a magnet in his name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VCTA_1n_E_Wiww_T_Spn_Jdg5z5h_AAG_Lk4_UB_4ftmrj_JF_9w_P3_JC_1439b4d57a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

