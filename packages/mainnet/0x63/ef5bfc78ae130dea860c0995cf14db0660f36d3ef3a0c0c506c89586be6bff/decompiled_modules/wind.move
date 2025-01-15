module 0x63ef5bfc78ae130dea860c0995cf14db0660f36d3ef3a0c0c506c89586be6bff::wind {
    struct WIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIND>(arg0, 6, b"WIND", b"Wind Ai Meme", b"Get ready for the $Wind! The BIGGEST MEME AI TOKEN is here to blow your mind!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059549_e749f49855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

