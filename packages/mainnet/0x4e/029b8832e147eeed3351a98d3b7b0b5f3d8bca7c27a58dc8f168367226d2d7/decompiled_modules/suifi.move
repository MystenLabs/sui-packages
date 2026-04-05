module 0x4e029b8832e147eeed3351a98d3b7b0b5f3d8bca7c27a58dc8f168367226d2d7::suifi {
    struct SUIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFI>(arg0, 6, b"Suifi", b"Suifi pil", b"Suifi - the gratest pil for the sui holders ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8551_84993a5642.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

