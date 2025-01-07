module 0xf828fd13e2e426cdf55dc2d7860ddd16a383a44083c1ff61f6292f68624e327f::err {
    struct ERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERR>(arg0, 6, b"ERR", b"ER", b"er", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/daniel_shapiro_r5_K_Fjt_Lv_B_I_unsplash_3c962d5f7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

