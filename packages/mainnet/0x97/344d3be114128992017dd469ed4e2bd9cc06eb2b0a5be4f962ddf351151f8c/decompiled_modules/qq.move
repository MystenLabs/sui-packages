module 0x97344d3be114128992017dd469ed4e2bd9cc06eb2b0a5be4f962ddf351151f8c::qq {
    struct QQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ>(arg0, 6, b"QQ", b"qq", b"I'm QQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYTL_Ojak_AA_2_Mf_Z_273ac7c6db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

