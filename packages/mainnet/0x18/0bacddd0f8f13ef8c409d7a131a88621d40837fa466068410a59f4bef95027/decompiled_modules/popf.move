module 0x180bacddd0f8f13ef8c409d7a131a88621d40837fa466068410a59f4bef95027::popf {
    struct POPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPF>(arg0, 6, b"POPF", b"Popfish", b"Popfish , the fish leader on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Vision_XL_Create_a_surreal_image_of_a_bright_blue_fis_0_0492a35ef0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

