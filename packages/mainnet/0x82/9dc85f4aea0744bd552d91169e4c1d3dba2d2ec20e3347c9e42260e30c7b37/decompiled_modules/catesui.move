module 0x829dc85f4aea0744bd552d91169e4c1d3dba2d2ec20e3347c9e42260e30c7b37::catesui {
    struct CATESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATESUI>(arg0, 6, b"CATESUI", b"CATE ON SUI", x"43415445204f4e205355490a0a5445414d20544f4b454e532057494c4c20474554204255524e5420414c4f4e472054484520574159", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catesuilogo_020a3d0f6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

