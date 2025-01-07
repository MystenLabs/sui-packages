module 0xc4f47e2a32dad49ceae0f7a6182b7c9433e4fa04c6c583ae1380ce0b8f7ae33b::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 3, b"Joycat", b"JoyCat", b"JoyCat controls the memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F01_FEE_2_E7_006_D_4_C54_A96_D_9_AF_571_BDCB_82_a345d65a84.jpeg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOYCAT>(&mut v2, 2200000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

