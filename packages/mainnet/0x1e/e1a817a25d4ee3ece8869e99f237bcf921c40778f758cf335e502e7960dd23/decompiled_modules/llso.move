module 0x1ee1a817a25d4ee3ece8869e99f237bcf921c40778f758cf335e502e7960dd23::llso {
    struct LLSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLSO>(arg0, 6, b"LlSO", b"Liso", x"244c49534f2074686520756e7761766572696e6720736869656c64206f662068656176656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_U4_R_Uo_FUL_9_A757w_Z4b_C6_Dv_U7_Y_Li_S4_VHVAX_2t5_GQMRB_Wr_a25b5b454e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

