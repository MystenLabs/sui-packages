module 0x162beebaa2c53d18ea243c5b89b7bad6322f45a6fd47017b0be98a0161c6cf46::pudgai {
    struct PUDGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGAI>(arg0, 6, b"PUDGAI", b"PUDGY AI", b"Where meme meets digital", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PUDGY_68d3bad040.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

