module 0x8a092e5a22e5b2909725d89fbde203f8b66ae1a84a7b4ac071d77f184c617a03::gorklon {
    struct GORKLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORKLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORKLON>(arg0, 6, b"Gorklon", b"gorklon rust", x"47726f6b2d580a476f726b6c6f6e2d576f726c640a537569203e20536f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_JJ_Eiss_I_400x400_05341e5b78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORKLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORKLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

