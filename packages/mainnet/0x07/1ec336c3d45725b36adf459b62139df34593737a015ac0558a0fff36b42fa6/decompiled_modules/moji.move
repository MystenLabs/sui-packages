module 0x71ec336c3d45725b36adf459b62139df34593737a015ac0558a0fff36b42fa6::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"MOJI Agent", b"The first emoji AI agent ON suI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_Lj_Wbu4_H_400x400_28939581fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

