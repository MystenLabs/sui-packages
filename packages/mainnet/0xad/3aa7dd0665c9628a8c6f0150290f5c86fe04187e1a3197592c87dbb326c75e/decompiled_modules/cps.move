module 0xad3aa7dd0665c9628a8c6f0150290f5c86fe04187e1a3197592c87dbb326c75e::cps {
    struct CPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPS>(arg0, 6, b"CPS", b"Chill Pepe On Sui", b"Chill Pepe On Sui Now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_25_at_11_02_58_bbbd5241_e7311b3506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

