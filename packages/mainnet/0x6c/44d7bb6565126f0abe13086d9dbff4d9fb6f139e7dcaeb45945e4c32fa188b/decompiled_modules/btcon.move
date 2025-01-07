module 0x6c44d7bb6565126f0abe13086d9dbff4d9fb6f139e7dcaeb45945e4c32fa188b::btcon {
    struct BTCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCON>(arg0, 6, b"BTCON", b"Peter Todd", b"BTC OWNER PETER TODD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4f5r3_ZOU_400x400_5d74dc3ec1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCON>>(v1);
    }

    // decompiled from Move bytecode v6
}

