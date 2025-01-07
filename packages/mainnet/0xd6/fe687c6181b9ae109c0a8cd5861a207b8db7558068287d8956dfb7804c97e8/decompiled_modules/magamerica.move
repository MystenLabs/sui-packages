module 0xd6fe687c6181b9ae109c0a8cd5861a207b8db7558068287d8956dfb7804c97e8::magamerica {
    struct MAGAMERICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAMERICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAMERICA>(arg0, 6, b"MAGAMERICA", b"MAGA Magnet America", x"204d414741202d2d2d2d2d2d2d2d2d2d3e3e3e3e3e3e3e4d414b4520414d455249434120475245415420414741494e21204576656e206d61676e6574206b6e6f77732077686f277320746865207269676874206f6e652e204d414741202d2d2d2d2d2d2d2d2d2d3e3e3e3e3e3e3e4d414b4520414d455249434120475245415420414741494e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uqq_Pdhes_GJ_Vj_Kd_V9_Et_T371_Aru3_MW_8o_C6_Xu7f_Hw_J43p5c_00c8b88478_fad6fec206.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAMERICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAMERICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

