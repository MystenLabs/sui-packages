module 0x39ec21659797b9d20b2dadc94f9d8eb5244f5d139dba6d471982d6f0240d577f::kek {
    struct KEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEK>(arg0, 6, b"Kek", b"Suikek", b"Kekius backwards - Suikek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2071_18f4f092eb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

