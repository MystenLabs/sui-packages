module 0x921f082143faba52ffd4b84b66eb5ef84b6c32a5a955b9d19d37afa11d4bf8d3::suimoodeng {
    struct SUIMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOODENG>(arg0, 6, b"suiMoodeng", b"Moodeng", x"4d6f6f2044656e672066696e616c6c7920646562757473206e65772074656574680a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GXDO_9_TC_Xc_AE_5_Z6t_75c5ad8ae4.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

