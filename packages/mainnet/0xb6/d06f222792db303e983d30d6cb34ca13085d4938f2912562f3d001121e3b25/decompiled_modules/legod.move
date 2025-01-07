module 0xb6d06f222792db303e983d30d6cb34ca13085d4938f2912562f3d001121e3b25::legod {
    struct LEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOD>(arg0, 6, b"LEGOD", b"Lego God SUI", b"Building faith, one block at a time. LEGOD is a divine twist on classic construction, blending timeless wisdom with timeless bricks. Join the journey to piece together miracles, mysteries, and maybe even a few heavenly laughs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6u6o3t_2b7e35b915.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

