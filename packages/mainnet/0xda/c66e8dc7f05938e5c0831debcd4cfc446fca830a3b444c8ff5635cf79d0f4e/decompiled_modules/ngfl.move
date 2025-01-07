module 0xdac66e8dc7f05938e5c0831debcd4cfc446fca830a3b444c8ff5635cf79d0f4e::ngfl {
    struct NGFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGFL>(arg0, 6, b"NGFL", b"NotGonnaFuckingLie", b"NotGonnaFuckingLie test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_dc60e4ec8f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

