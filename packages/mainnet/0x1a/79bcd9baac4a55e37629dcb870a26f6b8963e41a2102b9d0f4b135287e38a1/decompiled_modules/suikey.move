module 0x1a79bcd9baac4a55e37629dcb870a26f6b8963e41a2102b9d0f4b135287e38a1::suikey {
    struct SUIKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEY>(arg0, 6, b"Suikey", b"SUIKEY", b"I am SUIkey not monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1341728835804_pic_710df036ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

