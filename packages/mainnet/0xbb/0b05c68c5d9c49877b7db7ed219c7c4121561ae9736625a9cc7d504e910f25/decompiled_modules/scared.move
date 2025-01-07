module 0xbb0b05c68c5d9c49877b7db7ed219c7c4121561ae9736625a9cc7d504e910f25::scared {
    struct SCARED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARED>(arg0, 6, b"SCARED", b"Dont Hug Me im Scared", x"506f70756c617220596f75747562652073657269657320616d617373696e67206f7665722031206d696c6c696f6e2076696577732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Hf_Fz1_Wt8s_GQW_Uxqw_Vxqvk_Zsw7_Fw_Lx_Gs_USQPKD_8x_Ny_Ge_94feca5f94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARED>>(v1);
    }

    // decompiled from Move bytecode v6
}

