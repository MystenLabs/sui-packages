module 0x852c7d01e96b0ec6f26ec911d30932c66d25fc879adbb682f11593e8baf86a95::duckz {
    struct DUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZ>(arg0, 6, b"Duckz", b"SuiDuckz", b"Duckz meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_99be895a60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

