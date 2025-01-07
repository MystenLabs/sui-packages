module 0xfae011e2de8e2ead8f2c8030b3f1bf99fa5eec610396c2f75dec22aa1afd7104::bmaga {
    struct BMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMAGA>(arg0, 6, b"BMAGA", b"Black MAGA", b"Make America Great Again ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6594_52851dc01b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

