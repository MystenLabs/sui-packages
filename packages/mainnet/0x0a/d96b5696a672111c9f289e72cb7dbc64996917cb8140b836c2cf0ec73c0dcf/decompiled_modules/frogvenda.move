module 0xad96b5696a672111c9f289e72cb7dbc64996917cb8140b836c2cf0ec73c0dcf::frogvenda {
    struct FROGVENDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGVENDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGVENDA>(arg0, 6, b"FrogVenda", b"Frog Venda", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2c2b78e4_5848_44bb_ac69_0115b74d8e39_50e76853d9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGVENDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGVENDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

