module 0xbe5d8dae15191a4c21216e621d8e90148aa9f204912fec5c8ff43b376118b5f5::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"COCO COIN", x"436f636f20697320737569206e6574776f726b206e6f772120556e6c696d6974656420657874656e73696f6e2074686520706f776572206f6620736f6369616c206e6574776f726b730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/top_virus_CO_0ue_Wv_C_417ace35f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

