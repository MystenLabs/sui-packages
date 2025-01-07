module 0x2a3e0c821fb5aebbed45187825e500cf751da4d508da7ca4526cd7bfbf5a9c5b::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"SUISHI", b"Welcome to SUISHI!! Only chads can eat me, there are no seats for jeets at this buffet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishi_673f7562c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

