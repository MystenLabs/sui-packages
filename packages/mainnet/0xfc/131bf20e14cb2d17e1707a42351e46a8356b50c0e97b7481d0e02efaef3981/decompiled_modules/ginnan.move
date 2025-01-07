module 0xfc131bf20e14cb2d17e1707a42351e46a8356b50c0e97b7481d0e02efaef3981::ginnan {
    struct GINNAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINNAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINNAN>(arg0, 6, b"GINNAN", b"GINNAN CAT", b"Ginnan the Cat is a cat meme commeownity that is based on the Doge lore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ada_2b121b70d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINNAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINNAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

