module 0x38749bb1dd392d1c2dd92708e265d3671825f1dc4f7f45180bd48845c7bb7882::err {
    struct ERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERR>(arg0, 6, b"ERR", b"DFF", b"xzxzxz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/daniel_shapiro_r5_K_Fjt_Lv_B_I_unsplash_9253b53dc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

