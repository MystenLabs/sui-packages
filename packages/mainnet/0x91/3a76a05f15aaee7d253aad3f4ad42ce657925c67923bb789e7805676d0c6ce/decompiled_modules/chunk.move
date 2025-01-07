module 0x913a76a05f15aaee7d253aad3f4ad42ce657925c67923bb789e7805676d0c6ce::chunk {
    struct CHUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNK>(arg0, 6, b"CHUNK", b"Chunk", b"Clear the way, it's Chunk time. Secure your spot at the foundation or watch it soar - without you. Your move.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sbfaqv_Mefox_X_Fe_L_Lkc53_Uob_H_Mvp9z_X2_Gjr_Q_Vb_Sruo_ZVE_79ab30f30c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

