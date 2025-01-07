module 0x8c07e1d4aca2c179a897ba72171a6487901e4f5bbd3cffcd5f73a65b70574352::perm {
    struct PERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERM>(arg0, 6, b"PERM", b"PERM SUI", b"I am $PERM on sui chain, just like without me would be no life, same in crypto without me no profit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qpylge6_Y_400x400_b5fecec68d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

