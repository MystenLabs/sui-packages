module 0x2d88b62fefb31e189f4be44e80fcd3b0311dabfac8b22d2cc16b339c930547d8::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"Billy Bass AI", b"www.billybassai.xyz . Somethings fishy. I kinda like it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pf_HE_Lpy_T_400x400_b0112a7a78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

