module 0xc2991fea6decf2973a18d73f8cf87aa2c0150a3ceea018d716b9f4cd21229b6d::pkk {
    struct PKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKK>(arg0, 6, b"PKK", b"pookk", b"pllkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_23_18_36_20_883b6817ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

