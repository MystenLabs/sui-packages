module 0xfda7359440fba22226e3b31f6e62092ff27654610c68b5f7cd2034cb9a31afde::dck {
    struct DCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCK>(arg0, 6, b"DCK", b"DUCKY KAL", b"Ducky is sticky and meme coin Leading SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elizabeth_Gintama_icon_1_76e27d0ed7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

