module 0x8d5142bee2f0b071431818e2c0ed3bd322adfc678bdb5b07e684ed01d009d513::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCS>(arg0, 6, b"BTCS", b"Bitcoin on Sui", b"Send it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_eb656ed768.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

