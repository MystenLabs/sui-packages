module 0x16318304ef06df41e01f41e2bae178f85526513162303d5ef129fd7fbd8da6b3::bliz {
    struct BLIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIZ>(arg0, 6, b"BLIZ", b"Baby Lizard", x"42616279204c697a617264206f6e205355492069732061626f757420746f20626520756e6c65617368656421200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_I_Gg_TS_R_400x400_1_350058022c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

