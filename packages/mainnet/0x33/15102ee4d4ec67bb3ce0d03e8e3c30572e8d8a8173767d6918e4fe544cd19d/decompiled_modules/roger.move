module 0x3315102ee4d4ec67bb3ce0d03e8e3c30572e8d8a8173767d6918e4fe544cd19d::roger {
    struct ROGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGER>(arg0, 6, b"ROGER", b"DETECTIVE MOODENG", b"Welcome to Detective Moodeng SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wq_S3_K8_H2ahv_Rt_MWT_9_Liugs_Kicmxkzy_Vihn1modtv9_U_Dd_37b90d04c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

