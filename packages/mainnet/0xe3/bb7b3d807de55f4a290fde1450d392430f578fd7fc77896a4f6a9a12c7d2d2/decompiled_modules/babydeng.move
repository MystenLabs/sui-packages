module 0xe3bb7b3d807de55f4a290fde1450d392430f578fd7fc77896a4f6a9a12c7d2d2::babydeng {
    struct BABYDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDENG>(arg0, 6, b"BABYDENG", b"BABYDENG ON SUI", b"$BabyDeng  https://linktr.ee/babydeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_Zhj0_s_400x400_a599ec8c90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

