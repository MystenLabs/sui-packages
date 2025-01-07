module 0x3f4938ae6ff93c40eaa41fd256cb04587413778f781cc098797139ec2a1ed720::scream {
    struct SCREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAM>(arg0, 6, b"SCREAM", b"SUI SCREAM", b"Don't Answer The Door, Don't Leave The House, Don't Scream!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241227_020519_286_ee95f22e5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

