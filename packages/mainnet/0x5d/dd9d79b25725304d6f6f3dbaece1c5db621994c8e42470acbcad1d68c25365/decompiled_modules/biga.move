module 0x5ddd9d79b25725304d6f6f3dbaece1c5db621994c8e42470acbcad1d68c25365::biga {
    struct BIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGA>(arg0, 6, b"BIGA", b"BIGACHAD", b"BIGACHAD $BIGA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9736_21153e3c02.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

