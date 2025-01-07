module 0x8df5ddad6e293b23c6630fbbfbf2274158d89e50c4acb869945cc53caeffe0c2::butt {
    struct BUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTT>(arg0, 6, b"BUTT", b"Buttcoin", b"Missed attaining financial freedom with Bitcoin? The Buttcoin community seeks a second chance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fy_Qwpn_KF_400x400_77a6b23f51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

