module 0x29d3a595a1bbce9f0ebf5d7ce8bdb6d11f7dbf8599444d679f21ab90e90e0a6d::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"Crazy Sui", b"Crazy, crazy, crazy!!!To the moon with SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_c9df690b8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CS>>(v1);
    }

    // decompiled from Move bytecode v6
}

