module 0xc667797947d938b81b29ace84f3c9c9ad2bc2a26f9282116f5f83c490ef06bfa::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"Bog", b"BOG", x"24424f47206973206261736564206f66660a4d61747420467572696527732046697273740a46726f6720696c6c757374726174696f6e20696e0a323030342e200a0a4865206973207468652046726f670a466174686572206f662050455045", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004735_c5e6cb5dbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

