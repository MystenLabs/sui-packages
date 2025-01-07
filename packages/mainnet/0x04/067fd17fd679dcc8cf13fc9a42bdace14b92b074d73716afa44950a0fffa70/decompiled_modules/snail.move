module 0x4067fd17fd679dcc8cf13fc9a42bdace14b92b074d73716afa44950a0fffa70::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 6, b"SNAIL", b"SuiSnail", b"Fuck the cats and dogs. Ape in the SuiSnail and wake up with diamond hands. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_18_58_51_e1b5e5039f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

