module 0x145b293d2e17a281ba980701d2c996a6fefa0065a9b538eca556553925a07155::bopo {
    struct BOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPO>(arg0, 6, b"BOPO", b"BOOK OF POCHITA", x"20424f4f4b204f4620504f43484954410a40426f6f6b4f665f506f6368697461", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D3_F_Kf2q_Q_400x400_b04eef9a58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

