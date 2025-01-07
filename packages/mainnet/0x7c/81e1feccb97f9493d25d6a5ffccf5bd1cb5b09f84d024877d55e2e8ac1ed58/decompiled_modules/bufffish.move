module 0x7c81e1feccb97f9493d25d6a5ffccf5bd1cb5b09f84d024877d55e2e8ac1ed58::bufffish {
    struct BUFFFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFFISH>(arg0, 6, b"BuffFish", b"BUFF FISH", b"KING OF THE WATER CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_Jw_Em_DR_Dp8_D_Puc_K_Spv_Sc7v_L_Aq_4d0802f848.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFFFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

