module 0x73b653b7b50d89edb4f3b696eddaf11aba0081a2fd097244c70a5e96404a1bc0::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"Andy", b"White Whale Andy", x"4368696e612053616e7961202041746c616e74697320417175617269756d20412062656c756761207768616c652077697468206d616e7920616273206e616d656420416e64790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2g_LRPMUR_Ymeju_Kyk1_Ci_J9e4_Jim_Ma_Ww_D4e5q9_R_Ub_Mpump_acc818bceb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

