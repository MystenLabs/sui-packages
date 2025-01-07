module 0x50563baa1cb6a18769bf7b782a3c90e7fc15be57c9605cd8d8aeb6c3d0fa0d65::spodeng {
    struct SPODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPODENG>(arg0, 6, b"SPODENG", b"SUI POPDENG", b"#popdeng Memecoin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/podeng_63da38f988.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

