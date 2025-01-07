module 0xbd18a7a539e69480bf5c57dde0271e358d583ecd795950c358139ce33aa26d31::kinky {
    struct KINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINKY>(arg0, 6, b"KINKY", b"Baby Kinkajou", b"Kinky is just a baby kinkajou ready to take on the world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5865_06fe8ba73c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

