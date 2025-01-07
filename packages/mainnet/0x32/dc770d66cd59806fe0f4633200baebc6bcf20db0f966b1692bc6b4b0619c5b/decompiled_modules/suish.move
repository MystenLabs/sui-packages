module 0x32dc770d66cd59806fe0f4633200baebc6bcf20db0f966b1692bc6b4b0619c5b::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"SUISHI", b"Welcome to SUISHI!! Only chads can eat me, there are no seats for jeets at this buffet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishi_ba1efbc947.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

