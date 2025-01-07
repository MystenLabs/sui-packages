module 0x5074bcdc89b8d3a6ff12597d97c7924fbf394f76a029cb9c24aafcc299f8d768::suilana {
    struct SUILANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANA>(arg0, 6, b"SUILANA", b"Suilana", b"Its not solana,its better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6050712002499823046_m_775a376852.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

