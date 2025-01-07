module 0x1c10263c58c0a026592f4bb3f5f93823476ef6028660644bbe54735e163efec0::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 6, b"Joycat", b"JoyCat", b"JoyCat controls the memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01_FEE_2_E7_006_D_4_C54_A96_D_9_AF_571_BDCB_82_a345d65a84.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

