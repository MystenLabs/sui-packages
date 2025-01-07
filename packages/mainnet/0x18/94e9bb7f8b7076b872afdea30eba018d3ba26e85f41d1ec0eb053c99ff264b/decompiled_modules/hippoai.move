module 0x1894e9bb7f8b7076b872afdea30eba018d3ba26e85f41d1ec0eb053c99ff264b::hippoai {
    struct HIPPOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOAI>(arg0, 6, b"HIPPOAI", b"HIPPO AI", b"Moo Deng has become an AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippo_9cc147c20b.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

