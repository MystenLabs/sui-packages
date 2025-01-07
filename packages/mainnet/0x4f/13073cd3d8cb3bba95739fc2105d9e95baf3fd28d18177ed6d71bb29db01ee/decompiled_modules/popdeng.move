module 0x4f13073cd3d8cb3bba95739fc2105d9e95baf3fd28d18177ed6d71bb29db01ee::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"POPDENG", b"POPDENG ON SUI", x"0a0a0a0a4974206d69676874206e6f742062652065617379200a49742773206d6967687420626520736c6f77200a4974206d69676874206e6f742062652077697365200a0a427574206f6e6c79206f6e6520504f5044454e472063616e206368616e676520796f7572206c6966652021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/circle_frame_image_50eedc29d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

