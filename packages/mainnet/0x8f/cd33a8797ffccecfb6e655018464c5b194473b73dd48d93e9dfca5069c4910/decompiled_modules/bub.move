module 0x8fcd33a8797ffccecfb6e655018464c5b194473b73dd48d93e9dfca5069c4910::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 6, b"BUB", b"BUBSUI", b"$BUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qyr_X_Rv2pm_Qhmgjj_W3whw_MS_4_M_Xsr_BQ_1sn7du_Mtmq_Cth_Rn_e8c2ad9d7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

