module 0x89123de7aaedf3aeaa8db1caaee50636e82803a262379a8f042fc8284ea15dfb::zombieclub {
    struct ZOMBIECLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIECLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIECLUB>(arg0, 6, b"ZombieCLUB", b"Zombie Animal Club", x"5a4f4d42494520414e494d414c20434c55420a576974682048616c6c6f7765656e206a7573742061726f756e642074686520636f726e65722c20245a41432068617320726973656e2066726f6d20746865206465616420616e642069732074616b696e67206f766572206261736520636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RNF_3gk3_Wd_Ub_Q_Qt_Mhz_Vqn_X_Pzac_Kp_ZDQ_Abv_J9_Hcoy_Z4_SCG_145fbd1bc9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIECLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIECLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

