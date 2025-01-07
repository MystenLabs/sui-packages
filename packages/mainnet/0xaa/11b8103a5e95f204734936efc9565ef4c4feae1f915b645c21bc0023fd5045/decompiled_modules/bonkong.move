module 0xaa11b8103a5e95f204734936efc9565ef4c4feae1f915b645c21bc0023fd5045::bonkong {
    struct BONKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKONG>(arg0, 6, b"BONKONG", b"Bonk Kong", b"Where Memes and Bananas Collide! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_5ab23c2b95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

