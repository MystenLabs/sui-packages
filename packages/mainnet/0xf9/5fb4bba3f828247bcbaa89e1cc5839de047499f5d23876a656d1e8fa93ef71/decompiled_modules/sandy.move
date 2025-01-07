module 0xf95fb4bba3f828247bcbaa89e1cc5839de047499f5d23876a656d1e8fa93ef71::sandy {
    struct SANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDY>(arg0, 6, b"SANDY", b"$SANDY", b"\"Thrilled to have you join the Sandy community! Let's embark on this exciting journey together with our brand-new token on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_9_5feaf769a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

