module 0xb01ac75eaf0bca4d64ea09256d07bf4e3530b7e04047fd09a0331d122830d6d8::catlong {
    struct CATLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLONG>(arg0, 6, b"CATLONG", b"CAT LONG", b"LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000126965_b8c6cd252d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

