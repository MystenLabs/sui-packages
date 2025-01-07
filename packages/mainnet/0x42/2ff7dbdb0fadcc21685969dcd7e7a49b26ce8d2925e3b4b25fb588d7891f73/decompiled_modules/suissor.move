module 0x422ff7dbdb0fadcc21685969dcd7e7a49b26ce8d2925e3b4b25fb588d7891f73::suissor {
    struct SUISSOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSOR>(arg0, 6, b"SUISSOR", b"SuiSSor", x"446f6e742047657420437574210a20446f6e742047657420437574210a20446f6e742047657420437574210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_21_25_39_91b2bb9e47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

