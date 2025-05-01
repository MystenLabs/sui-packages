module 0xe661851465105a696c5ca26be9945324c1de2f5edbc468bb872f13c7a4d73ef7::dripcoin {
    struct DRIPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPCOIN>(arg0, 6, b"DRIPCOIN", b"Dripcoin", b"Dripcoin is SUI's premier meme token. No TG, no cabal, drip freely!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chat_GPT_Image_May_1_2025_09_43_09_AM_modified_d75cf83fe7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

