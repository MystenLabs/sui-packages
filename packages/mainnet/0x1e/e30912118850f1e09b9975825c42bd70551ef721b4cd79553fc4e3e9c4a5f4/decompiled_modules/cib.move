module 0x1ee30912118850f1e09b9975825c42bd70551ef721b4cd79553fc4e3e9c4a5f4::cib {
    struct CIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIB>(arg0, 6, b"CIB", b"CATINBNANA", b"CNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANACNANA CNANA CNANA CNANA CNANA CNANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5fe27c55a160429_upscaled_9af7d267fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

