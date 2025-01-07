module 0x216ecc7bbf69b0a4166c8b97485e51801a294d9b45206c75dabba9cf312484de::mola {
    struct MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLA>(arg0, 6, b"MOLA", b"Mola SUI", b"Kookiest Goofballs of the Sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3g_Xmxq_SEZWM_Nsi_G8_VQZRY_Dr_VC_Sf_Hvi_Xs_Xm_Vftboy_Jcnk_eea94d3fec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

