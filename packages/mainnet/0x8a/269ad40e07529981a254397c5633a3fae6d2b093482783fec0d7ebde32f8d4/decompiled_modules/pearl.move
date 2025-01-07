module 0x8a269ad40e07529981a254397c5633a3fae6d2b093482783fec0d7ebde32f8d4::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"Pearl", b"Steven universe", b"1.1 Pearl one of many", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae4659a339bc086dcd454dd897efeaa8_1_90e4f9ae7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

