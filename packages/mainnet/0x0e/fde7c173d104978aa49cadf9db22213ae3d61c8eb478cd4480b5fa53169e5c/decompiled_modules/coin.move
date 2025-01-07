module 0xefde7c173d104978aa49cadf9db22213ae3d61c8eb478cd4480b5fa53169e5c::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"michi", b"michi", b"The most memeable cat on Internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suipump.meme/uploads/michi_e2090b9554.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

