module 0x578953b913fca5ef88be9387cd2e6829042670931419416131fc8874e3ba6dcf::trshmnky {
    struct TRSHMNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSHMNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSHMNKY>(arg0, 6, b"TRSHMNKY", b"Rick is Ridiculous Raccoon Coin", b"Rick's Ridiculous Raccoon Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tq6y_S_Vw_Fifh7pr_M2rdiw_E7_Usk5vjf_RC_Zp8o_Xhj_Vw_Wuo_H_de4edf6a7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSHMNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRSHMNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

