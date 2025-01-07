module 0xdb178ae48d8df56a10e077ba62108e0be2cd712cba0be2d92ff32525431bd40d::gizmo {
    struct GIZMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIZMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIZMO>(arg0, 6, b"GIZMO", b"GIZMO SUI", b"GIZMO is a meme-coin named after the co-founder of yuga labs Greg sui dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_26_19_40_56_2c1562a462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIZMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIZMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

