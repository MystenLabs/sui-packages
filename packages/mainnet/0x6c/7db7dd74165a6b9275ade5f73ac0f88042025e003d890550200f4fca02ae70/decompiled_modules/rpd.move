module 0x6c7db7dd74165a6b9275ade5f73ac0f88042025e003d890550200f4fca02ae70::rpd {
    struct RPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPD>(arg0, 6, b"RPD", b"REPOST DOG", b" JUST REPOST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Up2q_MM_Gu_A_Czi_Key_Z_Rt_H9cu_Kyqt_Ypq_J24i_Zg6t_V_Lpump_53d378d72b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

