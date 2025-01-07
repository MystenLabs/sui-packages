module 0xf651bf7067dee8e41cb559ecb933aaa17ea71267887c684ca2288c2601f87195::wrac {
    struct WRAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRAC>(arg0, 6, b"WRAC", b"World Richest Art Cat", b"The World's Richest Art Cat meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WRAC_e3d90aafb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

