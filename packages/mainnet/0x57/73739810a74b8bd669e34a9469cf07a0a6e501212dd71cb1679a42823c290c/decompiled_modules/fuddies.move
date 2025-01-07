module 0x5773739810a74b8bd669e34a9469cf07a0a6e501212dd71cb1679a42823c290c::fuddies {
    struct FUDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIES>(arg0, 6, b"Fuddies", b"Fuddies Meme", b"Extra special owls means an extra special community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fuddies_2c6f32c1b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

