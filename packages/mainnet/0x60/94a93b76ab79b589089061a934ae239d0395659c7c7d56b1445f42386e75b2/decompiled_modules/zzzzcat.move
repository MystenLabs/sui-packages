module 0x6094a93b76ab79b589089061a934ae239d0395659c7c7d56b1445f42386e75b2::zzzzcat {
    struct ZZZZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZZCAT>(arg0, 6, b"ZZZZCAT", b"SNOOZE CAT", b" The Sui Cat's Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iu_F_Yoea_I_400x400_2bf442bbe6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

