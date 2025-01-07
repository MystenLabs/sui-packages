module 0xa4437edc40ec9c31a0ecca75ea1ec4f5868ae72170a06b56e0f6140d0141c35d::rwlf {
    struct RWLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWLF>(arg0, 6, b"RWLF", b"RainWolf", b"A musical wolf of chaos and color that landed here holding on to the spark that connects her to the stars.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240915003556_b24165ec4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RWLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

