module 0x37262e0ec85628c213a9c51e728d8676fa26e45f46d6122f34418087de5fc9f5::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"The first Moodeng on Sui ($MOODENG)", x"4d6f6f44656e6720697320736f2061646f7261626c652e20446973636f766572204d6f6f44656e6727732066756e6e79206d6f6d656e74732e426577617265206f662066616b6520636f6e7472616374730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dab4b0f7d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

