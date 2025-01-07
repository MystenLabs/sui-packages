module 0x17f54a89bc39906e8074d27823d87ed7571fff421d4867b41fe840cdb036a1b9::liquor {
    struct LIQUOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUOR>(arg0, 6, b"Liquor", b"Beliquoronsui", x"65206c6971756f722c206d7920667269656e642e204e657720657261206f66206d656d65206f6e205375692e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/liquer_07d4a1db38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

