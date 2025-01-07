module 0x7a0f414853b125caa91c6452b88b0c7dde17dd4ef91a3f482746a6e6f2814f99::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"POPDENG", b"POPDENG on SUI", x"24504f5044454e470a0a4974206d69676874206e6f742062652065617379200a49742773206d6967687420626520736c6f77200a4974206d69676874206e6f742062652077697365200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/circle_frame_image_e681ce8ad1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

