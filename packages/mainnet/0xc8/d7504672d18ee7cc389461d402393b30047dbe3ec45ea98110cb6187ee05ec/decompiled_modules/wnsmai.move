module 0xc8d7504672d18ee7cc389461d402393b30047dbe3ec45ea98110cb6187ee05ec::wnsmai {
    struct WNSMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNSMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNSMAI>(arg0, 6, b"WNSMAI", b"Why not Supermeme AI", b"World needs a hero! Why not Supermeme AI?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/492045_F1_951_B_4_CC_0_89_AE_59_C9_E42721_F5_4cbb3310fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNSMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WNSMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

